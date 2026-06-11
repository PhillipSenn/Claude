app.version = 8
if (document.getElementById('app-version')) {
	document.getElementById('app-version').textContent = 'v' + app.version
}

// Photorealistic 3D map with Age of Empires style camera:
// edge-of-screen panning, scroll zoom, Q/E rotation, click-to-identify places.

app.map3d = null
app.Marker3DElement = null
app.Place = null
app.marker = null
app.pan = {x: 0, y: 0}   // -1..1, screen-relative pan direction
app.rotate = 0           // -1 = Q (counterclockwise), 1 = E (clockwise)
app.edge = 48            // px from map edge that triggers panning
app.panSpeed = 0.012     // fraction of camera range moved per frame
app.rotateSpeed = 1.5    // degrees per frame

function init_map() {
	google.maps.importLibrary('maps3d').then(init_maps3d)
	google.maps.importLibrary('places').then(init_places)
}

function init_places(response) {
	app.Place = response.Place
}

function init_maps3d(response) {
	app.Marker3DElement = response.Marker3DElement
	var param = {}
	param.center = {}
	param.center.lat = 35.7326   // Union Square, Hickory NC
	param.center.lng = -81.3412
	param.center.altitude = 365
	param.range = 1200
	param.tilt = 60
	param.heading = 0
	param.mode = 'HYBRID'
	app.map3d = new response.Map3DElement(param)
	document.getElementById('Map3DWrapper').appendChild(app.map3d)
	app.map3d.addEventListener('gmp-click', map3d_gmp_click)
	requestAnimationFrame(animate)
}

// --- Camera loop ---

function animate() {
	if (app.map3d) {
		move_camera()
	}
	requestAnimationFrame(animate)
}

function move_camera() {
	var map = app.map3d
	var heading = map.heading || 0 // heading can be undefined before the map finishes loading
	if (app.rotate !== 0) {
		map.heading = (heading + app.rotate * app.rotateSpeed + 360) % 360
	}
	if (app.pan.x !== 0 || app.pan.y !== 0) {
		var center = map.center
		if (!center) {return}
		var h = heading * Math.PI / 180
		var speed = Math.max(map.range, 100) * app.panSpeed
		// Rotate the screen pan vector by the camera heading so panning is always screen-relative
		var east = (app.pan.x * Math.cos(h) + app.pan.y * Math.sin(h)) * speed
		var north = (app.pan.y * Math.cos(h) - app.pan.x * Math.sin(h)) * speed
		var param = {}
		param.lat = center.lat + north / 111320
		param.lng = center.lng + east / (111320 * Math.cos(center.lat * Math.PI / 180))
		param.altitude = center.altitude
		map.center = param
	}
}

// --- Edge panning ---

function document_mousemove(e) {
	if (!app.map3d) {return}
	var rect = app.map3d.getBoundingClientRect()
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

function map3d_gmp_click(event) {
	event.preventDefault()
	if (!event.placeId) {
		clear_selection()
		return
	}
	event.fetchPlace().then(fetch_place_fields)
}

function fetch_place_fields(response) {
	var param = {}
	param.fields = ['displayName', 'formattedAddress', 'types', 'location', 'rating', 'userRatingCount', 'googleMapsLinks']
	response.fetchFields(param).then(show_place)
}

function show_place(response) {
	display_place(response.place)
}

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
	highlight_place(place)
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

// --- Search ---

function place_search() {
	var query = $('#place-search').val()
	if (!query || !app.Place || !app.map3d) {return}
	var center = app.map3d.center
	var param = {}
	param.textQuery = query
	param.fields = ['displayName', 'formattedAddress', 'types', 'location', 'rating', 'userRatingCount', 'googleMapsLinks']
	param.maxResultCount = 1
	if (center) {
		param.locationBias = {}
		param.locationBias.lat = center.lat
		param.locationBias.lng = center.lng
	}
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
	var center = app.map3d.center
	var param = {}
	param.endCamera = {}
	param.endCamera.center = {}
	param.endCamera.center.lat = place.location.lat()
	param.endCamera.center.lng = place.location.lng()
	param.endCamera.center.altitude = center ? center.altitude : 0
	param.endCamera.range = 800
	param.endCamera.tilt = 60
	param.endCamera.heading = app.map3d.heading || 0
	param.durationMillis = 2000
	app.map3d.flyCameraTo(param)
}

function highlight_place(place) {
	remove_marker()
	if (!place.location) {return}
	var param = {}
	param.position = {}
	param.position.lat = place.location.lat()
	param.position.lng = place.location.lng()
	param.position.altitude = 30
	param.altitudeMode = 'RELATIVE_TO_MESH'
	param.extruded = true
	param.label = place.displayName || ''
	app.marker = new app.Marker3DElement(param)
	app.map3d.append(app.marker)
}

function remove_marker() {
	if (app.marker) {
		app.marker.remove()
		app.marker = null
	}
}

function clear_selection() {
	$('#place-name').text('Selected Place')
	$('#place-details').addClass('d-none')
	$('#place-empty').removeClass('d-none')
	remove_marker()
}

$(document).on('mousemove', document_mousemove)
$(document).on('keydown', document_keydown)
$(document).on('keyup', document_keyup)
$(document).on('click', '#place-search-btn', place_search)
$(document).on('keydown', '#place-search', place_search_keydown)
$(window).on('blur', window_blur)
