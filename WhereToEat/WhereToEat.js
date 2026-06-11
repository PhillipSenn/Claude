app.version = 2
document.getElementById('app-version').textContent = 'v' + app.version

// Where To Eat: geolocates you, finds the nearest restaurants (sorted by
// distance), and shows them one at a time with Previous / Next buttons.
// Every photo links to its full-size source on Google.
// v2: photos (and all other fields) are now requested directly in
// searchNearby instead of via fetchFields, which returned no photos.

app.Place = null
app.RankPreference = null
app.places = []
app.index = 0
app.origin = null

$(document).ready(docReady)

function docReady() {
	$(document).on('click', '#prev-btn', prev_btn)
	$(document).on('click', '#next-btn', next_btn)
}

// Called by the Google Maps loader (callback=init_map in WhereToEat.cfm)
function init_map() {
	google.maps.importLibrary('places').then(init_places)
}

function init_places(response) {
	app.Place = response.Place
	app.RankPreference = response.SearchNearbyRankPreference
	if (!navigator.geolocation) {
		showStatus('Geolocation is not supported by this browser.', 'danger')
		return
	}
	showStatus('Finding your location&hellip;', 'info')
	navigator.geolocation.getCurrentPosition(geoSuccess, geoError)
}

function geoSuccess(position) {
	app.origin = {}
	app.origin.lat = position.coords.latitude
	app.origin.lng = position.coords.longitude
	searchNearby()
}

function geoError(error) {
	showStatus('Could not get your location: ' + error.message, 'danger')
}

function searchNearby() {
	showStatus('Searching for nearby restaurants&hellip;', 'info')
	var param = {}
	param.fields = ['id', 'displayName', 'location', 'formattedAddress', 'rating', 'userRatingCount', 'priceLevel', 'nationalPhoneNumber', 'websiteURI', 'googleMapsURI', 'photos']
	param.locationRestriction = {}
	param.locationRestriction.center = app.origin
	param.locationRestriction.radius = 8000
	param.includedPrimaryTypes = ['restaurant']
	param.maxResultCount = 20
	param.rankPreference = app.RankPreference.DISTANCE
	app.Place.searchNearby(param).then(searchNearbyDone).catch(searchNearbyFail)
}

function searchNearbyDone(response) {
	app.places = response.places
	if (app.places.length === 0) {
		showStatus('No restaurants found nearby.', 'warning')
		return
	}
	hideStatus()
	$('#restaurant-area').removeClass('d-none')
	app.index = 0
	showRestaurant()
}

function searchNearbyFail(error) {
	showStatus('Restaurant search failed: ' + error.message, 'danger')
}

function showRestaurant() {
	var place = app.places[app.index]
	$('#counter').text((app.index + 1) + ' of ' + app.places.length)
	$('#prev-btn').prop('disabled', app.index === 0)
	$('#next-btn').prop('disabled', app.index === app.places.length - 1)
	renderName(place)
	renderPhotos(place)
	renderInfo(place)
	renderLocation(place)
}

function renderName(place) {
	var a = $('<a>')
	a.attr('href', place.googleMapsURI)
	a.attr('target', '_blank')
	a.attr('rel', 'noopener')
	a.text(place.displayName)
	$('#restaurant-name').empty().append(a)
}

function renderPhotos(place) {
	$('#photos').empty()
	if (!place.photos || place.photos.length === 0) {
		$('#photos').html('<div class="text-muted p-3">No photos available.</div>')
		return
	}
	$.each(place.photos, each_photo)
}

function each_photo(i, photo) {
	var param = {}
	param.maxWidth = 1600
	var href = photo.getURI(param)
	param.maxWidth = 400
	var thumb = photo.getURI(param)
	var img = $('<img>')
	img.attr('src', thumb)
	img.attr('alt', 'Restaurant photo ' + (i + 1))
	img.addClass('img-fluid rounded w-100')
	var a = $('<a>')
	a.attr('href', href)
	a.attr('target', '_blank')
	a.attr('rel', 'noopener')
	if (photo.authorAttributions && photo.authorAttributions.length > 0) {
		a.attr('title', 'Photo by ' + photo.authorAttributions[0].displayName)
	}
	a.append(img)
	var col = $('<div>')
	col.addClass('col-6 col-lg-4')
	col.append(a)
	$('#photos').append(col)
}

function renderInfo(place) {
	var parts = []
	if (place.rating) {
		parts.push('&#9733; ' + place.rating + ' (' + place.userRatingCount + ' reviews)')
	}
	var price = priceText(place.priceLevel)
	if (price) {
		parts.push(price)
	}
	if (place.nationalPhoneNumber) {
		parts.push('<a href="tel:' + place.nationalPhoneNumber + '">' + place.nationalPhoneNumber + '</a>')
	}
	if (place.websiteURI) {
		parts.push('<a href="' + place.websiteURI + '" target="_blank" rel="noopener">Website</a>')
	}
	if (parts.length === 0) {
		parts.push('<span class="text-muted">No details available.</span>')
	}
	$('#info').html(parts.join(' &middot; '))
}

function priceText(priceLevel) {
	var result = ''
	if (priceLevel === 'INEXPENSIVE') {
		result = '$'
	} else if (priceLevel === 'MODERATE') {
		result = '$$'
	} else if (priceLevel === 'EXPENSIVE') {
		result = '$$$'
	} else if (priceLevel === 'VERY_EXPENSIVE') {
		result = '$$$$'
	}
	return result
}

function renderLocation(place) {
	var miles = distanceMiles(app.origin, place.location)
	$('#distance').text(miles.toFixed(1) + ' miles from you')
	var a = $('<a>')
	a.attr('href', place.googleMapsURI)
	a.attr('target', '_blank')
	a.attr('rel', 'noopener')
	a.text(place.formattedAddress)
	$('#address').empty().append(a)
}

function distanceMiles(origin, location) {
	var R = 3958.8 // Earth radius in miles
	var lat1 = origin.lat * Math.PI / 180
	var lat2 = location.lat() * Math.PI / 180
	var dLat = lat2 - lat1
	var dLng = (location.lng() - origin.lng) * Math.PI / 180
	var h = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dLng / 2) * Math.sin(dLng / 2)
	return 2 * R * Math.asin(Math.sqrt(h))
}

function prev_btn() {
	if (app.index > 0) {
		app.index = app.index - 1
		showRestaurant()
	}
}

function next_btn() {
	if (app.index < app.places.length - 1) {
		app.index = app.index + 1
		showRestaurant()
	}
}

function showStatus(html, type) {
	$('#status').attr('class', 'alert alert-' + type).html(html)
}

function hideStatus() {
	$('#status').attr('class', 'd-none')
}
