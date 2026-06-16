app.version = 8
document.getElementById('app-version').innerHTML = '&bull; v' + app.version

app.artPage = parseInt(new URLSearchParams(window.location.search).get('page'), 10) || 1
app.artTotal = 0
app.scrollHighWater = 0
app.loading = false
app.iiifUrl = 'https://www.artic.edu/iiif/2'
app.attributes = [
	['Artist', 'artist_display'],
	['Title', 'title'],
	['Place', 'place_of_origin'],
	['Date', 'date_display'],
	['Medium', 'medium_display'],
	['Inscriptions', 'inscriptions'],
	['Dimensions', 'dimensions'],
	['Credit Line', 'credit_line'],
	['Reference Number', 'main_reference_number']
]

$(document).on('click', '.btn-previous', btn_previous)
$(document).on('click', '.btn-next', btn_next)
$(window).on('scroll resize', window_scroll)
$('#painting-image').on('load', painting_image_load)

getPainting()

function window_scroll() {
	if (app.loading) {
		return
	}
	var docHeight = document.documentElement.scrollHeight
	var scrollTop = window.pageYOffset || document.documentElement.scrollTop
	var result = Math.round((scrollTop + window.innerHeight) / docHeight * 100)
	if (result > app.scrollHighWater) {
		app.scrollHighWater = result
		$('#scroll-progress').css('width', app.scrollHighWater + '%').attr('aria-valuenow', app.scrollHighWater).text(app.scrollHighWater + '%')
		if (app.scrollHighWater >= 100) {
			$('#scroll-progress').addClass('bg-success')
		}
	}
}

function painting_image_load() {
	app.loading = false
	window_scroll()
}

function btn_previous() {
	if (app.artPage > 1) {
		app.artPage = app.artPage - 1
		getPainting()
	}
}

function btn_next() {
	if (app.artTotal === 0 || app.artPage < app.artTotal) {
		app.artPage = app.artPage + 1
		window.scrollTo(0, 0)
		resetProgress()
		getPainting()
	}
}

function resetProgress() {
	app.scrollHighWater = 0
	$('#scroll-progress').css('width', '0%').attr('aria-valuenow', 0).text('').removeClass('bg-success')
}

function getPainting() {
	var data = {
		q: 'painting',
		'query[term][is_public_domain]': 'true',
		fields: 'id,title,image_id,description,artist_display,artist_id,place_of_origin,date_display,medium_display,inscriptions,dimensions,credit_line,main_reference_number',
		limit: 1,
		page: app.artPage
	}
	app.loading = true
	$('#painting-title').text('Loading…')
	$('.btn-previous,.btn-next').prop('disabled', true)
	history.replaceState(null, '', '?page=' + app.artPage)
	$.getJSON('https://api.artic.edu/api/v1/artworks/search', data, getPainting_response)
}

function getPainting_response(response) {
	var result = response.data[0]
	app.artTotal = response.pagination.total
	app.painting = result
	if (response.config && response.config.iiif_url) {
		app.iiifUrl = response.config.iiif_url
	}
	$('#painting-title').empty().append($('<a target="_blank">').attr('href', 'https://www.artic.edu/artworks/' + result.id).text(result.title))
	if (result.image_id) {
		$('#painting-image').attr('src', app.iiifUrl + '/' + result.image_id + '/full/843,/0/default.jpg').attr('alt', result.title).show()
	} else {
		$('#painting-image').hide()
		app.loading = false
	}
	if (result.description) {
		$('#painting-description').html(result.description)
	} else {
		$('#painting-description').empty()
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
		if (label === 'Artist' && app.painting.artist_id) {
			$('#painting-attributes').append($('<dd class="col-sm-9">').append($('<a target="_blank">').attr('href', 'https://www.artic.edu/artists/' + app.painting.artist_id).text(result)))
		} else {
			$('#painting-attributes').append($('<dd class="col-sm-9">').text(result))
		}
	}
}
