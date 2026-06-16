app.version = 6
document.getElementById('app-version').innerHTML = '&bull; v' + app.version

localStorage.removeItem('metViewed')
localStorage.removeItem('metSearch')

app.artPage = parseInt(new URLSearchParams(window.location.search).get('page'), 10) || 1
app.artTotal = 0
app.ids = []
app.scrollHighWater = 0
app.loading = true
app.direction = 1
app.apiUrl = 'https://collectionapi.metmuseum.org/public/collection/v1'
app.attributes = [
	['Artist', 'artistDisplayName'],
	['Artist Bio', 'artistDisplayBio'],
	['Title', 'title'],
	['Culture', 'culture'],
	['Date', 'objectDate'],
	['Medium', 'medium'],
	['Dimensions', 'dimensions'],
	['Classification', 'classification'],
	['Credit Line', 'creditLine'],
	['Accession Number', 'accessionNumber'],
	['Department', 'department'],
	['Gallery', 'GalleryNumber']
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
		app.direction = -1
		app.artPage = app.artPage - 1
		getPainting()
	}
}

function btn_next() {
	if (app.artPage < app.artTotal) {
		app.direction = 1
		app.artPage = app.artPage + 1
		window.scrollTo(0, 0)
		resetProgress()
		getPainting()
	}
}

function getSearch() {
	var data = {
		q: 'painting',
		hasImages: true,
		medium: 'Paintings'
	}
	$.getJSON(app.apiUrl + '/search', data, getSearch_response)
}

function getSearch_response(response) {
	app.ids = response.objectIDs
	app.artTotal = response.total
	if (app.artPage > app.artTotal) {
		app.artPage = 1
	}
	getPainting()
}

function getPainting() {
	app.loading = true
	$('#painting-title').text('Loading…')
	$('.btn-previous,.btn-next').prop('disabled', true)
	history.replaceState(null, '', '?page=' + app.artPage)
	$.getJSON(app.apiUrl + '/objects/' + app.ids[app.artPage - 1], getPainting_response)
}

function getPainting_response(response) {
	var result = response
	if (!result.primaryImageSmall && !result.primaryImage) {
		if (app.direction === 1 && app.artPage < app.artTotal) {
			app.artPage = app.artPage + 1
			getPainting()
			return
		}
		if (app.direction === -1 && app.artPage > 1) {
			app.artPage = app.artPage - 1
			getPainting()
			return
		}
	}
	app.painting = result
	$('#painting-title').empty().append($('<a target="_blank">').attr('href', result.objectURL).text(result.title))
	if (result.primaryImageSmall || result.primaryImage) {
		$('#painting-image').attr('src', result.primaryImageSmall || result.primaryImage).attr('alt', result.title).show()
	} else {
		$('#painting-image').hide()
		app.loading = false
	}
	$('#painting-attributes').empty()
	$.each(app.attributes, each_attribute)
	$('#painting-counter').text(app.artPage.toLocaleString() + ' of ' + app.artTotal.toLocaleString())
	$('.btn-previous').prop('disabled', app.artPage <= 1)
	$('.btn-next').prop('disabled', app.artPage >= app.artTotal)
	window_scroll()
}

function each_attribute(index, attribute) {
	var label = attribute[0]
	var result = app.painting[attribute[1]]
	if (result) {
		$('#painting-attributes').append($('<dt class="col-sm-3">').text(label))
		if (label === 'Artist' && app.painting.artistWikidata_URL) {
			$('#painting-attributes').append($('<dd class="col-sm-9">').append($('<a target="_blank">').attr('href', app.painting.artistWikidata_URL).text(result)))
		} else {
			$('#painting-attributes').append($('<dd class="col-sm-9">').text(result))
		}
	}
}
