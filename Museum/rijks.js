app.version = 2
document.getElementById('app-version').innerHTML = '&bull; v' + app.version

app.artPage = parseInt(new URLSearchParams(window.location.search).get('page'), 10) || 1
app.artTotal = 0
app.ids = []
app.nextUrl = ''
app.scrollHighWater = 0
app.loading = true
app.searchUrl = 'https://data.rijksmuseum.nl/search/collection?type=painting&imageAvailable=true'
app.laParams = {_profile: 'la-framed', _mediatype: 'application/ld+json'}
app.EN = 'http://vocab.getty.edu/aat/300388277'
app.attributes = [
	['Artist', 'artist'],
	['Title', 'title'],
	['Place', 'place'],
	['Date', 'date'],
	['Medium', 'medium'],
	['Dimensions', 'dimensions'],
	['Credit Line', 'creditLine'],
	['Object Number', 'objectNumber']
]

$(document).on('click', '.btn-previous', btn_previous)
$(document).on('click', '.btn-next', btn_next)
$(window).on('scroll resize', window_scroll)
$('#painting-image').on('load', painting_image_load)

getSearch()

function window_scroll() {
	if (app.loading) {
		return
	}
	var docHeight = document.documentElement.scrollHeight
	var scrollTop = window.pageYOffset || document.documentElement.scrollTop
	var result = Math.round((scrollTop + window.innerHeight) / docHeight * 100)
	if (result > app.scrollHighWater) {
		app.scrollHighWater = result
		$('#painting-progress').css('width', app.scrollHighWater + '%').attr('aria-valuenow', app.scrollHighWater).text(app.scrollHighWater + '%')
		if (app.scrollHighWater >= 100) {
			$('#painting-progress').addClass('bg-success')
		}
	}
}

function painting_image_load() {
	app.loading = false
	window_scroll()
}

function resetProgress() {
	app.scrollHighWater = 0
	$('#painting-progress').css('width', '0%').attr('aria-valuenow', 0).text('').removeClass('bg-success')
}

function btn_previous() {
	if (app.artPage > 1) {
		app.artPage = app.artPage - 1
		getPainting()
	}
}

function btn_next() {
	if (app.artPage < app.artTotal) {
		app.artPage = app.artPage + 1
		window.scrollTo(0, 0)
		resetProgress()
		getPainting()
	}
}

function dataUrl(id) {
	return id.replace('https://id.rijksmuseum.nl/', 'https://data.rijksmuseum.nl/')
}

function getSearch() {
	$.getJSON(app.nextUrl || app.searchUrl, getSearch_response)
}

function getSearch_response(response) {
	var i
	app.artTotal = response.partOf.totalItems
	for (i = 0; i < response.orderedItems.length; i++) {
		app.ids.push(response.orderedItems[i].id)
	}
	app.nextUrl = response.next ? response.next.id : ''
	if (app.artPage > app.artTotal) {
		app.artPage = 1
	}
	if (app.ids.length < app.artPage && app.nextUrl) {
		getSearch()
	} else {
		getPainting()
	}
}

function getPainting() {
	app.loading = true
	$('#painting-title').text('Loading…')
	$('.btn-previous,.btn-next').prop('disabled', true)
	history.replaceState(null, '', '?page=' + app.artPage)
	if (app.ids.length < app.artPage && app.nextUrl) {
		getSearch()
	} else {
		$.getJSON(dataUrl(app.ids[app.artPage - 1]), app.laParams, getObject_response)
	}
}

function getObject_response(response) {
	app.painting = {
		artist: la_artist(response),
		title: la_title(response),
		place: la_place(response),
		date: la_date(response),
		medium: la_referred(response, '300435429'),
		dimensions: la_referred(response, '300435430'),
		creditLine: la_referred(response, '300026687'),
		objectNumber: la_objectNumber(response),
		webUrl: la_webUrl(response)
	}
	if (app.painting.webUrl) {
		$('#painting-title').empty().append($('<a target="_blank">').attr('href', app.painting.webUrl).text(app.painting.title))
	} else {
		$('#painting-title').text(app.painting.title)
	}
	$('#painting-description').text(la_description(response))
	$('#painting-attributes').empty()
	$.each(app.attributes, each_attribute)
	$('#painting-counter').text(app.artPage.toLocaleString() + ' of ' + app.artTotal.toLocaleString())
	$('.btn-previous').prop('disabled', app.artPage <= 1)
	$('.btn-next').prop('disabled', app.artPage >= app.artTotal)
	if (response.shows && response.shows.length) {
		$.getJSON(dataUrl(response.shows[0].id), app.laParams, getVisualItem_response).fail(image_missing)
	} else {
		image_missing()
	}
}

function getVisualItem_response(response) {
	if (response.digitally_shown_by && response.digitally_shown_by.length) {
		$.getJSON(dataUrl(response.digitally_shown_by[0].id), app.laParams, getDigitalObject_response).fail(image_missing)
	} else {
		image_missing()
	}
}

function getDigitalObject_response(response) {
	if (response.access_point && response.access_point.length) {
		var result = response.access_point[0].id.replace('/full/max/', '/full/800,/')
		$('#painting-image').attr('src', result).attr('alt', app.painting.title).show()
	} else {
		image_missing()
	}
}

function image_missing() {
	$('#painting-image').hide()
	app.loading = false
	window_scroll()
}

function each_attribute(index, attribute) {
	var label = attribute[0]
	var result = app.painting[attribute[1]]
	if (result) {
		$('#painting-attributes').append($('<dt class="col-sm-3">').text(label))
		$('#painting-attributes').append($('<dd class="col-sm-9">').text(result))
	}
}

function la_english(entry) {
	var i
	if (!entry.language) {
		return true
	}
	for (i = 0; i < entry.language.length; i++) {
		if (entry.language[i].id === app.EN) {
			return true
		}
	}
	return false
}

function la_notation(notation) {
	var i
	if (!notation) {
		return ''
	}
	if (!Array.isArray(notation)) {
		return notation['@value'] || ''
	}
	for (i = 0; i < notation.length; i++) {
		if (notation[i]['@language'] === 'en') {
			return notation[i]['@value']
		}
	}
	return notation.length ? notation[0]['@value'] : ''
}

function la_classified(entry, aatId) {
	var i, list = entry.classified_as || []
	for (i = 0; i < list.length; i++) {
		if (list[i].id && list[i].id.indexOf(aatId) > -1) {
			return true
		}
	}
	return false
}

function la_title(response) {
	var i, list = response.identified_by || []
	for (i = 0; i < list.length; i++) {
		if (list[i].type === 'Name' && la_english(list[i])) {
			return list[i].content
		}
	}
	for (i = 0; i < list.length; i++) {
		if (list[i].type === 'Name') {
			return list[i].content
		}
	}
	return 'Untitled'
}

function la_objectNumber(response) {
	var i, list = response.identified_by || []
	for (i = 0; i < list.length; i++) {
		if (list[i].type === 'Identifier' && la_classified(list[i], '300312355')) {
			return list[i].content
		}
	}
	return ''
}

function la_referred(response, aatId) {
	var i, list = response.referred_to_by || []
	for (i = 0; i < list.length; i++) {
		if (la_classified(list[i], aatId) && la_english(list[i])) {
			return list[i].content
		}
	}
	return ''
}

function la_artist(response) {
	var i, part = (response.produced_by && response.produced_by.part) || []
	for (i = 0; i < part.length; i++) {
		if (part[i].carried_out_by && part[i].carried_out_by.length) {
			return la_notation(part[i].carried_out_by[0].notation)
		}
	}
	return response.produced_by ? la_referred(response.produced_by, '300435416') : ''
}

function la_place(response) {
	var i, part = (response.produced_by && response.produced_by.part) || []
	for (i = 0; i < part.length; i++) {
		if (part[i].took_place_at && part[i].took_place_at.length) {
			return la_notation(part[i].took_place_at[0].notation)
		}
	}
	return ''
}

function la_date(response) {
	var timespan = response.produced_by && response.produced_by.timespan
	if (timespan && timespan.identified_by && timespan.identified_by.length) {
		return timespan.identified_by[0].content
	}
	return ''
}

function la_description(response) {
	var i, j, list = response.subject_of || []
	for (i = 0; i < list.length; i++) {
		if (list[i].part && la_english(list[i])) {
			for (j = 0; j < list[i].part.length; j++) {
				if (la_classified(list[i].part[j], '300048722')) {
					return list[i].part[j].content
				}
			}
		}
	}
	return ''
}

function la_webUrl(response) {
	var i, j, list = response.subject_of || []
	for (i = 0; i < list.length; i++) {
		if (list[i].digitally_carried_by) {
			for (j = 0; j < list[i].digitally_carried_by.length; j++) {
				if (list[i].digitally_carried_by[j].access_point && list[i].digitally_carried_by[j].access_point.length) {
					return list[i].digitally_carried_by[j].access_point[0].id
				}
			}
		}
	}
	return ''
}
