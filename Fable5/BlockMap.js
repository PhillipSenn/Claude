app.version = 2
if (document.getElementById('app-version')) {
	document.getElementById('app-version').textContent = 'v' + app.version
}

// SketchUp-style block city: MapLibre GL renders OpenStreetMap buildings as flat-shaded
// extruded boxes (OpenFreeMap tiles, no key needed). Age of Empires camera:
// edge-of-screen panning, scroll zoom, Q/E rotation. Click a building to highlight
// the actual structure and identify it with Google Places.

app.map = null
app.Place = null
app.pan = {x: 0, y: 0}   // -1..1, screen-relative pan direction
app.rotate = 0           // -1 = Q (counterclockwise), 1 = E (clockwise)
app.edge = 48            // px from map edge that triggers panning
app.panSpeed = 12        // px per frame
app.rotateSpeed = 1.5    // degrees per frame

// --- MapLibre map ---

function init_maplibre() {
	var param = {}
	param.container = 'MapWrapper'
	param.style = 'https://tiles.openfreemap.org/styles/liberty'
	param.center = [-81.3412, 35.7326] // Union Square, Hickory NC
	param.zoom = 16.5
	param.pitch = 60
	param.maxPitch = 75
	param.bearing = 0
	param.antialias = true
	app.map = new maplibregl.Map(param)
	app.map.on('load', map_load)
	app.map.on('click', map_click)
	requestAnimationFrame(animate)
}

function map_load() {
	var param = {}
	param.type = 'geojson'
	param.data = empty_geojson()
	app.map.addSource('selected-building', param)
	var layer = {}
	layer.id = 'selected-building'
	layer.type = 'fill-extrusion'
	layer.source = 'selected-building'
	layer.paint = {}
	layer.paint['fill-extrusion-color'] = '#fd7e14'
	layer.paint['fill-extrusion-opacity'] = 0.95
	layer.paint['fill-extrusion-height'] = ['coalesce', ['get', 'render_height'], 10]
	layer.paint['fill-extrusion-base'] = ['coalesce', ['get', 'render_min_height'], 0]
	app.map.addLayer(layer)
	hide_parking_icons()
}

// The 'P' symbols are OpenStreetMap parking icons; exclude them from the POI layers
function hide_parking_icons() {
	var layers = ['poi_r20', 'poi_r7', 'poi_r1']
	layers.forEach(each_poi_layer)
}

function each_poi_layer(id) {
	if (!app.map.getLayer(id)) {return}
	var filter = app.map.getFilter(id)
	app.map.setFilter(id, ['all', filter, ['!=', ['get', 'class'], 'parking']])
}

function empty_geojson() {
	var result = {}
	result.type = 'FeatureCollection'
	result.features = []
	return result
}

// --- Google Places (identify + search only) ---

function init_map() {
	google.maps.importLibrary('places').then(init_places)
}

function init_places(response) {
	app.Place = response.Place
}

// --- Camera loop ---

function animate() {
	if (app.map) {
		move_camera()
	}
	requestAnimationFrame(animate)
}

function move_camera() {
	if (app.rotate !== 0) {
		app.map.setBearing(app.map.getBearing() + app.rotate * app.rotateSpeed)
	}
	if (app.pan.x !== 0 || app.pan.y !== 0) {
		var param = {}
		param.duration = 0
		app.map.panBy([app.pan.x * app.panSpeed, -app.pan.y * app.panSpeed], param)
	}
}

// --- Edge panning ---

function document_mousemove(e) {
	if (!app.map) {return}
	var rect = app.map.getContainer().getBoundingClientRect()
	app.pan.x = 0
	app.pan.y = 0
	if (e.clientX >= rect.left && e.clientX <= rect.right && e.clientY >= rect.top && e.clientY <= rect.bottom) {
		if (e.clientX - rect.left < app.edge) {
			app.pan.x = -1
		} else if (rect.right - e.clientX < app.edge) {
			app.pan.x = 1
		}
		if (e.clientY - rect.top < app.edge) {
			app.pan.y = 1
		} else if (rect.bottom - e.clientY < app.edge) {
			app.pan.y = -1
		}
	}
}

// --- Rotation keys ---

function document_keydown(e) {
	if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') {return}
	if (e.key === 'q' || e.key === 'Q') {app.rotate = -1}
	if (e.key === 'e' || e.key === 'E') {app.rotate = 1}
	if (e.key === 'Escape') {clear_selection()}
}

function document_keyup(e) {
	if (e.key === 'q' || e.key === 'Q' || e.key === 'e' || e.key === 'E') {app.rotate = 0}
}

function window_blur() {
	app.pan.x = 0
	app.pan.y = 0
	app.rotate = 0
}

// --- Click to identify ---

function map_click(e) {
	var features = app.map.queryRenderedFeatures(e.point)
	var result = null
	var i
	for (i = 0; i < features.length; i++) {
		if (features[i].sourceLayer === 'building') {
			result = features[i]
			break
		}
	}
	if (!result) {
		clear_selection()
		return
	}
	highlight_building(result, e.lngLat)
	identify_place(e.lngLat)
}

// Vector tiles merge adjacent buildings into one MultiPolygon feature,
// so keep only the polygon that was actually clicked
function highlight_building(feature, lngLat) {
	var geometry = feature.geometry
	if (geometry.type === 'MultiPolygon') {
		var result = find_clicked_polygon(geometry.coordinates, lngLat)
		geometry = {}
		geometry.type = 'Polygon'
		geometry.coordinates = result
	}
	var data = empty_geojson()
	var item = {}
	item.type = 'Feature'
	item.geometry = geometry
	item.properties = feature.properties
	data.features.push(item)
	app.map.getSource('selected-building').setData(data)
}

function find_clicked_polygon(polygons, lngLat) {
	var result = null
	var i
	for (i = 0; i < polygons.length; i++) {
		if (ring_contains(polygons[i][0], lngLat)) {
			result = polygons[i]
			break
		}
	}
	if (!result) {
		result = nearest_polygon(polygons, lngLat)
	}
	return result
}

// Ray casting point-in-polygon test against the outer ring
function ring_contains(ring, lngLat) {
	var result = false
	var i
	var j = ring.length - 1
	for (i = 0; i < ring.length; i++) {
		var a = ring[i]
		var b = ring[j]
		if ((a[1] > lngLat.lat) !== (b[1] > lngLat.lat)) {
			if (lngLat.lng < (b[0] - a[0]) * (lngLat.lat - a[1]) / (b[1] - a[1]) + a[0]) {
				result = !result
			}
		}
		j = i
	}
	return result
}

// Fallback when the click hit an extruded wall rather than inside a footprint
function nearest_polygon(polygons, lngLat) {
	var result = polygons[0]
	var best = Infinity
	var i
	for (i = 0; i < polygons.length; i++) {
		var a = polygons[i][0][0]
		var d = Math.pow(a[0] - lngLat.lng, 2) + Math.pow(a[1] - lngLat.lat, 2)
		if (d < best) {
			best = d
			result = polygons[i]
		}
	}
	return result
}

function identify_place(lngLat) {
	if (!app.Place) {return}
	var param = {}
	param.fields = ['displayName', 'formattedAddress', 'types', 'location', 'rating', 'userRatingCount', 'googleMapsLinks']
	param.locationRestriction = {}
	param.locationRestriction.center = {}
	param.locationRestriction.center.lat = lngLat.lat
	param.locationRestriction.center.lng = lngLat.lng
	param.locationRestriction.radius = 40
	param.rankPreference = 'DISTANCE'
	param.maxResultCount = 1
	app.Place.searchNearby(param).then(show_nearby)
}

function show_nearby(response) {
	if (!response.places || response.places.length === 0) {
		$('#place-name').text('Unidentified building')
		$('#place-empty').addClass('d-none')
		$('#place-details').removeClass('d-none')
		$('#place-address').text('')
		$('#place-rating').empty()
		$('#place-types').empty()
		return
	}
	display_place(response.places[0])
}

// --- Sidebar ---

function display_place(place) {
	$('#place-empty').addClass('d-none')
	$('#place-details').removeClass('d-none')
	$('#place-name').text(place.displayName || 'Unnamed')
	$('#place-address').text(place.formattedAddress || '')
	$('#place-rating').empty()
	if (place.rating) {
		var rating = 'Rating: ' + place.rating + ' (' + (place.userRatingCount || 0) + ' reviews)'
		if (place.googleMapsLinks && place.googleMapsLinks.reviewsURI) {
			$('#place-rating').append($('<a>').attr('href', place.googleMapsLinks.reviewsURI).attr('target', '_blank').attr('rel', 'noopener').text(rating))
		} else {
			$('#place-rating').text(rating)
		}
	}
	$('#place-types').empty()
	if (place.types) {
		place.types.forEach(each_place_type)
	}
}

function each_place_type(type) {
	var result = type.replace(/_/g, ' ')
	$('#place-types').append($('<span>').addClass('badge me-1 mb-1 ' + type_badge_class(type)).text(result))
}

function type_badge_class(type) {
	var result = 'bg-secondary'
	if (/restaurant|food|cafe|coffee|bakery|bar|meal|pizza|sandwich/.test(type)) {
		result = 'bg-warning text-dark'
	} else if (/park|tourist_attraction|point_of_interest|natural_feature|stadium|zoo/.test(type)) {
		result = 'bg-success'
	} else if (/store|shopping|supermarket|grocery|clothing|furniture|market/.test(type)) {
		result = 'bg-primary'
	} else if (/hospital|doctor|pharmacy|health|dentist|veterinary/.test(type)) {
		result = 'bg-danger'
	} else if (/school|university|library|museum|education/.test(type)) {
		result = 'bg-info text-dark'
	} else if (/church|place_of_worship|mosque|synagogue|cemetery/.test(type)) {
		result = 'bg-dark'
	}
	return result
}

function clear_selection() {
	$('#place-name').text('Selected Place')
	$('#place-details').addClass('d-none')
	$('#place-empty').removeClass('d-none')
	if (app.map && app.map.getSource('selected-building')) {
		app.map.getSource('selected-building').setData(empty_geojson())
	}
}

// --- Search ---

function place_search() {
	var query = $('#place-search').val()
	if (!query || !app.Place || !app.map) {return}
	var center = app.map.getCenter()
	var param = {}
	param.textQuery = query
	param.fields = ['displayName', 'formattedAddress', 'types', 'location', 'rating', 'userRatingCount', 'googleMapsLinks']
	param.maxResultCount = 1
	param.locationBias = {}
	param.locationBias.lat = center.lat
	param.locationBias.lng = center.lng
	app.Place.searchByText(param).then(show_search)
}

function place_search_keydown(e) {
	if (e.key === 'Enter') {
		e.preventDefault()
		place_search()
	}
}

function show_search(response) {
	if (!response.places || response.places.length === 0) {
		$('#place-search').val('No results found')
		$('#place-search').trigger('select')
		return
	}
	var result = response.places[0]
	fly_to_place(result)
	display_place(result)
}

function fly_to_place(place) {
	if (!place.location) {return}
	var param = {}
	param.center = [place.location.lng(), place.location.lat()]
	param.zoom = 17
	param.duration = 2000
	app.map.flyTo(param)
}

$(document).on('mousemove', document_mousemove)
$(document).on('keydown', document_keydown)
$(document).on('keyup', document_keyup)
$(document).on('click', '#place-search-btn', place_search)
$(document).on('keydown', '#place-search', place_search_keydown)
$(window).on('blur', window_blur)

init_maplibre()
