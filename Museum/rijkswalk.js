app.version = 4
document.getElementById('app-version').innerHTML = '&bull; v' + app.version

app.artTotal = 0
app.ids = []
app.nextUrl = ''
app.searching = false
app.cache = {}
app.sections = {}
app.spacing = 700
app.camX = 0
app.camZ = 0
app.yaw = 0
app.minZ = 0
app.keys = {}
app.walkSpeed = 420
app.sprintSpeed = 420
app.sprintMax = 3200
app.sprintAccel = 900
app.lastTime = 0
app.lastSection = -1
app.searchUrl = 'https://data.rijksmuseum.nl/search/collection?type=painting&imageAvailable=true'
app.laParams = {_profile: 'la-framed', _mediatype: 'application/ld+json'}
app.EN = 'http://vocab.getty.edu/aat/300388277'
app.attributes = [
	['Artist', 'artist'],
	['Place', 'place'],
	['Date', 'date'],
	['Medium', 'medium'],
	['Dimensions', 'dimensions'],
	['Credit Line', 'creditLine'],
	['Object Number', 'objectNumber']
]

$(document).on('keydown', document_keydown)
$(document).on('keyup', document_keyup)
$(document).on('mousedown touchstart', '.btn-walk', btn_walk_down)
$(document).on('mouseup mouseleave touchend', '.btn-walk', btn_walk_up)
$(document).on('click', '.painting', painting_click)
$(document).on('click', '.btn-close-detail', btn_close_detail)

getSearch()

function document_keydown(e) {
	var map = {ArrowUp: 'forward', ArrowDown: 'back', ArrowLeft: 'left', ArrowRight: 'right', PageUp: 'sprintForward', PageDown: 'sprintBack'}
	var result = map[e.key]
	if (e.key === 'Escape') {
		$('#painting-detail').hide()
	}
	if (result) {
		app.keys[result] = true
		e.preventDefault()
	}
}

function document_keyup(e) {
	var map = {ArrowUp: 'forward', ArrowDown: 'back', ArrowLeft: 'left', ArrowRight: 'right', PageUp: 'sprintForward', PageDown: 'sprintBack'}
	var result = map[e.key]
	if (result) {
		app.keys[result] = false
	}
}

function btn_walk_down(e) {
	var self = $(this)
	app.keys[self.attr('data-walk')] = true
	e.preventDefault()
}

function btn_walk_up() {
	var self = $(this)
	app.keys[self.attr('data-walk')] = false
}

function painting_click() {
	var self = $(this)
	showDetail(parseInt(self.attr('data-index'), 10))
}

function btn_close_detail() {
	$('#painting-detail').hide()
}

function dataUrl(id) {
	return id.replace('https://id.rijksmuseum.nl/', 'https://data.rijksmuseum.nl/')
}

function getSearch() {
	if (app.searching) {
		return
	}
	app.searching = true
	$.getJSON(app.nextUrl || app.searchUrl, getSearch_response)
}

function getSearch_response(response) {
	var i, firstLoad = app.artTotal === 0
	app.searching = false
	app.artTotal = response.partOf.totalItems
	for (i = 0; i < response.orderedItems.length; i++) {
		app.ids.push(response.orderedItems[i].id)
	}
	app.nextUrl = response.next ? response.next.id : ''
	if (firstLoad) {
		startWalk()
	}
}

function startWalk() {
	var page = parseInt(new URLSearchParams(window.location.search).get('page'), 10) || 1
	if (page < 1 || page > app.artTotal) {
		page = 1
	}
	app.minZ = -(Math.ceil(app.artTotal / 2) * app.spacing) + 250
	app.camZ = -(Math.floor((page - 1) / 2) * app.spacing) + 250
	$('#world').append($('<div class="tile endwall">').css('transform', 'translate3d(0px, 0px, 450px) rotateY(180deg)'))
	app.lastTime = performance.now()
	requestAnimationFrame(tick)
}

function tick(now) {
	var dt = Math.min((now - app.lastTime) / 1000, 0.1)
	var turnSpeed = 1.8
	var cur
	app.lastTime = now
	if (app.keys.sprintForward || app.keys.sprintBack) {
		app.sprintSpeed = Math.min(app.sprintMax, app.sprintSpeed + app.sprintAccel * dt)
	} else {
		app.sprintSpeed = app.walkSpeed
	}
	if (app.keys.left) {
		app.yaw = app.yaw - turnSpeed * dt
	}
	if (app.keys.right) {
		app.yaw = app.yaw + turnSpeed * dt
	}
	if (app.keys.forward || app.keys.sprintForward) {
		app.camX = app.camX + Math.sin(app.yaw) * app.sprintSpeed * dt
		app.camZ = app.camZ - Math.cos(app.yaw) * app.sprintSpeed * dt
	}
	if (app.keys.back || app.keys.sprintBack) {
		app.camX = app.camX - Math.sin(app.yaw) * app.sprintSpeed * dt
		app.camZ = app.camZ + Math.cos(app.yaw) * app.sprintSpeed * dt
	}
	app.camX = Math.max(-170, Math.min(170, app.camX))
	app.camZ = Math.max(app.minZ, Math.min(330, app.camZ))
	document.getElementById('world').style.transform = 'translateZ(600px) rotateY(' + app.yaw + 'rad) translate3d(' + (-app.camX) + 'px, 0px, ' + (-app.camZ) + 'px)'
	cur = Math.max(0, Math.floor(-app.camZ / app.spacing))
	if (cur !== app.lastSection) {
		app.lastSection = cur
		updateSections(cur)
		updateHud(cur)
	}
	requestAnimationFrame(tick)
}

function updateSections(cur) {
	var s, keys, i
	for (s = Math.max(0, cur - 2); s <= cur + 6; s++) {
		if (!app.sections[s] && s * 2 < app.artTotal) {
			buildSection(s)
		}
	}
	keys = Object.keys(app.sections)
	for (i = 0; i < keys.length; i++) {
		s = parseInt(keys[i], 10)
		if (s < cur - 2 || s > cur + 6) {
			app.sections[s].remove()
			delete app.sections[s]
		}
	}
	if ((cur + 7) * 2 > app.ids.length && app.nextUrl) {
		getSearch()
	}
}

function buildSection(s) {
	var zc = -(s * app.spacing + app.spacing / 2)
	var $section = $('<div class="section">')
	$section.append($('<div class="tile floor">').css('transform', 'translate3d(0px, 170px, ' + zc + 'px) rotateX(90deg)'))
	$section.append($('<div class="tile ceiling">').css('transform', 'translate3d(0px, -170px, ' + zc + 'px) rotateX(-90deg)'))
	$section.append($('<div class="tile wall">').css('transform', 'translate3d(-300px, 0px, ' + zc + 'px) rotateY(90deg)'))
	$section.append($('<div class="tile wall">').css('transform', 'translate3d(300px, 0px, ' + zc + 'px) rotateY(-90deg)'))
	$section.append(paintingEl(s * 2, -1, zc))
	if (s * 2 + 1 < app.artTotal) {
		$section.append(paintingEl(s * 2 + 1, 1, zc))
	}
	app.sections[s] = $section
	$('#world').append($section)
	loadPainting(s * 2)
	loadPainting(s * 2 + 1)
}

function paintingEl(index, side, zc) {
	var result = app.cache[index]
	var $el = $('<div class="painting">').attr('data-index', index)
	$el.css('transform', 'translate3d(' + (side * 290) + 'px, 0px, ' + zc + 'px) rotateY(' + (side * -90) + 'deg)')
	$el.append($('<img>').attr('id', 'painting-img-' + index).attr('alt', ''))
	$el.append($('<div class="plaque">').attr('id', 'painting-plaque-' + index).text('…'))
	if (result && result.title) {
		$el.find('.plaque').text(plaqueText(result))
	}
	if (result && result.imgUrl) {
		$el.find('img').attr('src', result.imgUrl).attr('alt', result.title)
	}
	return $el
}

function plaqueText(result) {
	return result.title + (result.date ? ', ' + result.date : '')
}

function loadPainting(index) {
	if (app.cache[index] || index >= app.ids.length || index >= app.artTotal) {
		return
	}
	app.cache[index] = {state: 'loading'}
	$.getJSON(dataUrl(app.ids[index]), app.laParams, object_response).fail(object_fail)
	function object_response(response) {
		var result = app.cache[index]
		result.artist = la_artist(response)
		result.title = la_title(response)
		result.place = la_place(response)
		result.date = la_date(response)
		result.medium = la_referred(response, '300435429')
		result.dimensions = la_referred(response, '300435430')
		result.creditLine = la_referred(response, '300026687')
		result.objectNumber = la_objectNumber(response)
		result.webUrl = la_webUrl(response)
		result.description = la_description(response)
		$('#painting-plaque-' + index).text(plaqueText(result))
		if (response.shows && response.shows.length) {
			$.getJSON(dataUrl(response.shows[0].id), app.laParams, visual_response).fail(object_fail)
		}
	}
	function visual_response(response) {
		if (response.digitally_shown_by && response.digitally_shown_by.length) {
			$.getJSON(dataUrl(response.digitally_shown_by[0].id), app.laParams, digital_response).fail(object_fail)
		}
	}
	function digital_response(response) {
		var result = app.cache[index]
		if (response.access_point && response.access_point.length) {
			result.imgUrl = response.access_point[0].id.replace('/full/max/', '/full/400,/')
			result.state = 'done'
			$('#painting-img-' + index).attr('src', result.imgUrl).attr('alt', result.title)
		}
	}
	function object_fail() {
		$('#painting-plaque-' + index).text('Unavailable')
	}
}

function updateHud(cur) {
	var first = cur * 2 + 1
	var second = Math.min(cur * 2 + 2, app.artTotal)
	var percent = app.artTotal ? Math.round(second / app.artTotal * 100) : 0
	$('#painting-counter').text(first.toLocaleString() + (second > first ? '–' + second.toLocaleString() : '') + ' of ' + app.artTotal.toLocaleString())
	$('#painting-progress').css('width', percent + '%').attr('aria-valuenow', percent).text(percent + '%')
	if (percent >= 100) {
		$('#painting-progress').addClass('bg-success')
	} else {
		$('#painting-progress').removeClass('bg-success')
	}
	history.replaceState(null, '', '?page=' + first)
}

function showDetail(index) {
	var result = app.cache[index]
	if (!result || !result.title) {
		return
	}
	app.painting = result
	$('#detail-title').text(result.title)
	$('#detail-image').attr('src', result.imgUrl || '').attr('alt', result.title)
	$('#detail-description').text(result.description || '')
	$('#detail-attributes').empty()
	$.each(app.attributes, each_attribute)
	$('#detail-link').attr('href', result.webUrl || 'https://www.rijksmuseum.nl')
	$('#painting-detail').show()
}

function each_attribute(index, attribute) {
	var label = attribute[0]
	var result = app.painting[attribute[1]]
	if (result) {
		$('#detail-attributes').append($('<dt class="col-sm-4">').text(label))
		$('#detail-attributes').append($('<dd class="col-sm-8">').text(result))
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
