var app = {}
app.version = 11
app.allEvents = []

$(document).ready(docReady)

function docReady() {
	document.getElementById('app-version').innerHTML = '&bull; v' + app.version
	$(document).on('click', '#fetch-btn', fetchEvents)
	$(document).on('change', '.type-filter', filterEvents)
	$(document).on('keypress', '#year-input', handleYearKeypress)
	$(document).on('click', '#check-all-btn', checkAll)
	$(document).on('click', '#uncheck-all-btn', uncheckAll)
}

function handleYearKeypress(e) {
	if (e.which === 13) {
		fetchEvents()
	}
}

function fetchEvents() {
	var year = parseInt($('#year-input').val(), 10)
	if (!year || year < 1 || year > 2100) {
		alert('Please enter a valid year between 1 and 2100')
		return
	}
	app.allEvents = []
	$('#events-container').empty()
	$('#checkboxes-container').empty()
	$('#filters-area').hide()
	$('#results-count').text('')
	$('#loading').show()
	var sparql = buildSparqlQuery(year)
	var url = 'https://query.wikidata.org/sparql?query=' + encodeURIComponent(sparql) + '&format=json'
	$.ajax({
		url: url,
		method: 'GET',
		timeout: 30000,
		headers: {'Accept': 'application/sparql-results+json'},
		success: handleSparqlSuccess,
		error: handleSparqlError
	})
}

function buildSparqlQuery(year) {
	return [
		'SELECT ?event ?eventLabel ?type ?typeLabel',
		'  (SAMPLE(?img) AS ?image) (SAMPLE(?dt) AS ?date) (SAMPLE(?article) AS ?wikipedia) WHERE {',
		'  ?event wdt:P585 ?dt .',
		'  FILTER(YEAR(?dt) = ' + year + ')',
		'  ?event wdt:P31 ?type .',
		'  ?event wdt:P18 ?img .',
		'  OPTIONAL {',
		'    ?article schema:about ?event .',
		'    ?article schema:isPartOf <https://en.wikipedia.org/> .',
		'  }',
		'  SERVICE wikibase:label { bd:serviceParam wikibase:language "en" . }',
		'}',
		'GROUP BY ?event ?eventLabel ?type ?typeLabel',
		'ORDER BY ?date',
		'LIMIT 200'
	].join('\n')
}

function handleSparqlSuccess(response) {
	$('#loading').hide()
	var bindings = response.results.bindings
	if (!bindings || !bindings.length) {
		$('#events-container').html('<div class="col-12"><div class="alert alert-warning">No events found for this year. Try a different year.</div></div>')
		return
	}
	var eventMap = {}
	$.each(bindings, each_binding)
	function each_binding(i, row) {
		var id = row.event ? row.event.value : null
		if (!id) { return }
		if (!eventMap[id]) {
			eventMap[id] = {
				id: id,
				label: row.eventLabel ? row.eventLabel.value : id,
				types: [],
				typeIds: [],
				image: row.image ? row.image.value : null,
				date: row.date ? row.date.value : null,
				wikipedia: row.wikipedia ? row.wikipedia.value : null
			}
		}
		if (row.type) {
			var typeId = row.type.value
			var typeLabel = row.typeLabel ? row.typeLabel.value : typeId
			if (eventMap[id].typeIds.indexOf(typeId) === -1) {
				eventMap[id].typeIds.push(typeId)
				eventMap[id].types.push({id: typeId, label: typeLabel})
			}
		}
	}
	$.each(eventMap, each_eventMapEntry)
	function each_eventMapEntry(id, event) {
		event.qid = id.split('/').pop()
		app.allEvents.push(event)
	}
	app.allEvents.sort(sortByDate)
	var typeMap = buildTypeMap(app.allEvents)
	var types = typeMapToArray(typeMap)
	types.sort(sortByCount)
	buildCheckboxes(types)
	renderEvents(app.allEvents)
	$('#filters-area').show()
	updateResultsCount()
	fetchWikipediaImages(app.allEvents)
}

function buildTypeMap(events) {
	var typeMap = {}
	$.each(events, each_event)
	function each_event(i, event) {
		for (var j = 0; j < event.types.length; j++) {
			var type = event.types[j]
			if (!typeMap[type.id]) {
				typeMap[type.id] = {id: type.id, label: type.label, count: 0}
			}
			typeMap[type.id].count++
		}
	}
	return typeMap
}

function typeMapToArray(typeMap) {
	var types = []
	$.each(typeMap, each_typeEntry)
	function each_typeEntry(id, type) {
		types.push(type)
	}
	return types
}

function buildCheckboxes(types) {
	var html = '<div class="mb-2">'
	html += '<button id="check-all-btn" class="btn btn-sm btn-outline-secondary mr-1">All</button>'
	html += '<button id="uncheck-all-btn" class="btn btn-sm btn-outline-secondary">None</button>'
	html += '</div>'
	$.each(types, each_type)
	function each_type(i, type) {
		var safeId = escapeAttr(type.id)
		html += '<div class="mb-1">'
		html += '<label style="font-weight:normal;cursor:pointer;margin-bottom:0">'
		html += '<input type="checkbox" class="type-filter" data-type-id="' + safeId + '" checked> '
		html += escapeHtml(type.label)
		html += ' <span class="badge badge-secondary">' + type.count + '</span>'
		html += '</label>'
		html += '</div>'
	}
	$('#checkboxes-container').html(html)
}

function renderEvents(events) {
	var container = $('#events-container')
	container.empty()
	$.each(events, each_event)
	function each_event(i, event) {
		container.append(buildEventCard(event))
	}
}

function buildEventCard(event) {
	var label = escapeHtml(event.label)
	var dateStr = formatDate(event.date)
	var typeIdsAttr = escapeAttr(event.typeIds.join('|'))
	var hasImage = !!event.image
	var imgHtml = ''
	if (hasImage) {
		var imgUrl = event.image.replace('http://', 'https://') + '?width=300'
		if (event.wikipedia) {
			imgHtml = '<a class="card-img-link" href="' + event.wikipedia + '" target="_blank" rel="noopener">'
			imgHtml += '<img src="' + imgUrl + '" class="card-img-top" alt="' + label + '" style="width:100%;height:auto" onerror="this.parentNode.style.display=\'none\'">'
			imgHtml += '</a>'
		} else {
			imgHtml = '<img src="' + imgUrl + '" class="card-img-top" alt="' + label + '" style="width:100%;height:auto" onerror="this.style.display=\'none\'">'
		}
	}
	var badgesHtml = ''
	for (var i = 0; i < event.types.length; i++) {
		badgesHtml += '<span class="badge badge-info mr-1 mb-1">' + escapeHtml(event.types[i].label) + '</span>'
	}
	var classes = 'col-md-4 col-sm-6 mb-4 event-card'
	if (!hasImage) { classes += ' no-image' }
	var style = hasImage ? '' : ' style="display:none"'
	var html = '<div class="' + classes + '"' + style + ' data-type-ids="' + typeIdsAttr + '" data-qid="' + event.qid + '">'
	html += '<div class="card h-100 shadow-sm">'
	html += imgHtml
	html += '<div class="card-body d-flex flex-column">'
	html += '<h6 class="card-title">'
	html += '<a href="' + event.id + '" target="_blank" rel="noopener">' + label + '</a>'
	html += '</h6>'
	html += '<div class="mt-auto pt-1">' + badgesHtml + '</div>'
	html += '</div>'
	if (dateStr) {
		html += '<div class="card-footer text-muted small">' + dateStr + '</div>'
	}
	html += '</div>'
	html += '</div>'
	return html
}

function fetchWikipediaImages(events) {
	$.each(events, each_event)
	function each_event(i, event) {
		if (!event.wikipedia) { return }
		var title = event.wikipedia.replace('https://en.wikipedia.org/wiki/', '')
		var url = 'https://en.wikipedia.org/api/rest_v1/page/summary/' + title
		$.ajax({
			url: url,
			method: 'GET',
			context: {qid: event.qid, wikipedia: event.wikipedia},
			success: handleWikiSummary
		})
	}
}

function handleWikiSummary(result) {
	if (!result || !result.thumbnail) { return }
	var qid = this.qid
	var wikipedia = this.wikipedia
	var card = $('.event-card[data-qid="' + qid + '"]')
	if (!card.length) { return }
	var innerCard = card.find('.card')
	var imgSrc = result.thumbnail.source
	var existingLink = innerCard.find('a.card-img-link')
	if (existingLink.length) {
		existingLink.attr('href', wikipedia)
		existingLink.find('img').attr('src', imgSrc)
	} else {
		var imgHtml = '<a class="card-img-link" href="' + wikipedia + '" target="_blank" rel="noopener">'
		imgHtml += '<img src="' + imgSrc + '" class="card-img-top" style="width:100%;height:auto" alt="">'
		imgHtml += '</a>'
		innerCard.prepend(imgHtml)
		card.removeClass('no-image')
		var typeIdsStr = card.attr('data-type-ids')
		var typeIds = typeIdsStr ? typeIdsStr.split('|') : []
		var checked = []
		$('.type-filter:checked').each(each_filter)
		function each_filter() {
			checked.push($(this).data('type-id'))
		}
		var show = typeIds.length === 0
		for (var i = 0; i < typeIds.length; i++) {
			if (checked.indexOf(typeIds[i]) !== -1) {
				show = true
				break
			}
		}
		if (show) { card.show() }
		updateResultsCount()
	}
}

function filterEvents() {
	var checked = []
	$('.type-filter:checked').each(each_checked)
	function each_checked() {
		checked.push($(this).data('type-id'))
	}
	$('.event-card').each(each_card)
	function each_card() {
		var self = $(this)
		if (self.hasClass('no-image')) { return }
		var typeIdsStr = self.attr('data-type-ids')
		var typeIds = typeIdsStr ? typeIdsStr.split('|') : []
		var show = typeIds.length === 0
		for (var i = 0; i < typeIds.length; i++) {
			if (checked.indexOf(typeIds[i]) !== -1) {
				show = true
				break
			}
		}
		if (show) {
			self.show()
		} else {
			self.hide()
		}
	}
	updateResultsCount()
}

function checkAll() {
	$('.type-filter').prop('checked', true)
	filterEvents()
}

function uncheckAll() {
	$('.type-filter').prop('checked', false)
	filterEvents()
}

function handleSparqlError(xhr, status, error) {
	$('#loading').hide()
	var msg = (status === 'timeout')
		? 'Request timed out. Wikidata may be slow — try again.'
		: 'Error fetching data: ' + escapeHtml(error || status)
	$('#events-container').html('<div class="col-12"><div class="alert alert-danger">' + msg + '</div></div>')
}

function updateResultsCount() {
	var count = $('.event-card:visible').length
	$('#results-count').text('Showing ' + count + ' event' + (count !== 1 ? 's' : ''))
}

function sortByDate(a, b) {
	if (!a.date) { return 1 }
	if (!b.date) { return -1 }
	return a.date < b.date ? -1 : 1
}

function sortByCount(a, b) {
	return b.count - a.count
}

function formatDate(dateStr) {
	if (!dateStr) { return '' }
	var d = new Date(dateStr)
	if (isNaN(d.getTime())) { return dateStr }
	return d.toLocaleDateString('en-US', {year: 'numeric', month: 'long', day: 'numeric', timeZone: 'UTC'})
}

function escapeHtml(str) {
	if (!str) { return '' }
	return String(str)
		.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
		.replace(/"/g, '&quot;')
}

function escapeAttr(str) {
	if (!str) { return '' }
	return String(str).replace(/"/g, '&quot;').replace(/'/g, '&#39;')
}
