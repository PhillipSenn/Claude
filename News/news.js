// ChronAm.js — The Front Page
// Historic Newspaper Search Tool
// Calls Chronicling America via loc.gov JSON API

var currentPage = 1
var currentParams = {}
var totalResults = 0
var itemsPerPage = 20

// ---- Init ----

document.addEventListener('DOMContentLoaded', function () {
	setTodayDate()

	document.getElementById('searchKeyword').addEventListener('keydown', function (e) {
		if (e.key === 'Enter') {
			runSearch()
		}
	})
})

function setTodayDate() {
	var now = new Date()
	var options = { year: 'numeric', month: 'long', day: 'numeric' }
	document.getElementById('todayDate').textContent = now.toLocaleDateString('en-US', options)
}

// ---- Search ----

function runSearch() {
	currentPage = 1
	currentParams = buildParams()
	totalResults = 0

	clearResults()
	showLoading(true)

	fetchResults(currentParams, currentPage, function (data) {
		showLoading(false)
		totalResults = data.pagination ? data.pagination.total : 0
		var items = data.results || []

		if (items.length === 0) {
			showEmptyState()
			return
		}

		renderResultsHeader(totalResults)
		renderCards(items, false)
		updateLoadMoreBar()
	})
}

function loadMore() {
	currentPage = currentPage + 1
	showLoading(true)

	fetchResults(currentParams, currentPage, function (data) {
		showLoading(false)
		var items = data.results || []
		renderCards(items, true)
		updateLoadMoreBar()
	})
}

// ---- API Call ----

function buildParams() {
	var keyword = document.getElementById('searchKeyword').value.trim()
	var startDate = document.getElementById('startDate').value
	var endDate = document.getElementById('endDate').value
	var state = document.getElementById('stateFilter').value

	var params = {
		dl: 'page',
		fo: 'json',
		sp: '1'
	}

	if (keyword) {
		params.qs = keyword
	}
	if (startDate) {
		params.start_date = startDate
	}
	if (endDate) {
		params.end_date = endDate
	}
	if (state) {
		params.location_state = state.toLowerCase()
	}

	return params
}

function fetchResults(params, page, callback) {
	var query = Object.assign({}, params)
	query.c = itemsPerPage
	query.sp = page

	var queryString = Object.keys(query).map(function (key) {
		return encodeURIComponent(key) + '=' + encodeURIComponent(query[key])
	}).join('&')

	var url = 'https://www.loc.gov/collections/chronicling-america/?' + queryString

	fetch(url)
		.then(function (response) {
			return response.json()
		})
		.then(function (response) {
			var result = response
			callback(result)
		})
		.catch(function (err) {
			showLoading(false)
			showError()
			console.error('ChronAm API error:', err)
		})
}

// ---- Rendering ----

function renderResultsHeader(total) {
	var headerEl = document.getElementById('resultsHeader')
	var countEl = document.getElementById('resultCount')
	var queryEl = document.getElementById('resultQuery')
	var keyword = document.getElementById('searchKeyword').value.trim()
	var startDate = document.getElementById('startDate').value
	var endDate = document.getElementById('endDate').value

	countEl.textContent = total.toLocaleString() + ' issues found'

	var queryDesc = 'front pages'
	if (keyword) {
		queryDesc = 'matching \u201C' + keyword + '\u201D'
	}
	if (startDate && endDate) {
		queryDesc = queryDesc + ' \u00B7 ' + formatDateDisplay(startDate) + ' \u2013 ' + formatDateDisplay(endDate)
	}
	queryEl.textContent = queryDesc

	headerEl.classList.remove('d-none')
}

function renderCards(items, append) {
	var grid = document.getElementById('resultsGrid')
	if (!append) {
		grid.innerHTML = ''
	}

	items.forEach(function (item) {
		var col = document.createElement('div')
		col.className = 'col-12 col-sm-6 col-lg-4'
		col.innerHTML = buildCardHTML(item)
		grid.appendChild(col)
	})
}

function buildCardHTML(item) {
	var title = item.title || 'Untitled'
	var date = formatItemDate(item.date)
	var city = (item.city && item.city[0]) ? item.city[0] : ''
	var state = (item.state && item.state[0]) ? item.state[0] : ''
	var location = [city, state].filter(Boolean).join(', ')
	var snippet = (item.description && item.description[0]) ? item.description[0] : (item.excerpt || '')
	var pageUrl = item.url || buildAbsoluteUrl(item.id)
	var pdfUrl = buildAbsoluteUrl(item.pdf)

	var pdfLink = ''
	if (pdfUrl) {
		pdfLink = '<a class="card-link" href="' + pdfUrl + '" target="_blank" onclick="event.stopPropagation()">PDF</a>'
	}

	return '<a class="paper-card h-100" href="' + pageUrl + '" target="_blank">' +
		'<div class="card-masthead">' +
		'<p class="card-paper-title">' + escapeHTML(title) + '</p>' +
		'<p class="card-date">' + date + '</p>' +
		'</div>' +
		'<div class="card-body-inner">' +
		(location ? '<p class="card-location">' + escapeHTML(location) + '</p>' : '') +
		(snippet ? '<p class="card-snippet">' + escapeHTML(snippet) + '</p>' : '') +
		'</div>' +
		'<div class="card-link-row">' +
		'<a class="card-link" href="' + pageUrl + '" target="_blank" onclick="event.stopPropagation()">View Page</a>' +
		pdfLink +
		'</div>' +
		'</a>'
}

// ---- UI State ----

function clearResults() {
	document.getElementById('resultsGrid').innerHTML = ''
	document.getElementById('resultsHeader').classList.add('d-none')
	document.getElementById('loadMoreBar').classList.add('d-none')
	document.getElementById('emptyState').classList.add('d-none')
}

function showLoading(visible) {
	var el = document.getElementById('loadingState')
	if (visible) {
		el.classList.remove('d-none')
	} else {
		el.classList.add('d-none')
	}
}

function showEmptyState() {
	document.getElementById('emptyState').classList.remove('d-none')
}

function showError() {
	var grid = document.getElementById('resultsGrid')
	grid.innerHTML = '<div class="col-12"><p class="text-center" style="font-family:\'IBM Plex Mono\',monospace;font-size:0.8rem;color:var(--muted);">Could not reach the Library of Congress API. Please try again shortly.</p></div>'
}

function updateLoadMoreBar() {
	var bar = document.getElementById('loadMoreBar')
	var loaded = currentPage * itemsPerPage
	if (loaded < totalResults) {
		bar.classList.remove('d-none')
	} else {
		bar.classList.add('d-none')
	}
}

// ---- Utilities ----

function buildAbsoluteUrl(path) {
	if (!path) { return '' }
	if (path.indexOf('http://') === 0 || path.indexOf('https://') === 0) {
		return path.replace('http://www.loc.gov', 'https://www.loc.gov')
	}
	return 'https://www.loc.gov' + path
}

function formatItemDate(raw) {
	if (!raw) { return '' }
	var s = String(raw)
	if (s.length === 8) {
		var year = s.substring(0, 4)
		var month = s.substring(4, 6)
		var day = s.substring(6, 8)
		var d = new Date(year + '-' + month + '-' + day)
		return d.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
	}
	return raw
}

function formatDateDisplay(iso) {
	if (!iso) { return '' }
	var d = new Date(iso + 'T00:00:00')
	return d.toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' })
}

function escapeHTML(str) {
	if (!str) { return '' }
	return String(str)
		.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
		.replace(/"/g, '&quot;')
}