// WalletGraph.js
// Click-to-expand wallet relationship graph for Flare networks.
// Data source: Blockscout explorer API (Etherscan-compatible).
// Per-address data (name, balance, tx count) accumulates in IndexedDB.

var NETWORKS = {
	flare: {
		label: 'Flare',
		api: 'https://flare-explorer.flare.network/api',
		explorer: 'https://flare-explorer.flare.network',
		symbol: 'FLR'
	},
	songbird: {
		label: 'Songbird',
		api: 'https://songbird-explorer.flare.network/api',
		explorer: 'https://songbird-explorer.flare.network',
		symbol: 'SGB'
	},
	coston2: {
		label: 'Coston2',
		api: 'https://coston2-explorer.flare.network/api',
		explorer: 'https://coston2-explorer.flare.network',
		symbol: 'C2FLR'
	}
}

var app = {
	version: 3,
	network: 'flare',
	nodes: {},
	edges: {},
	blockies: {},
	selected: null,
	drag: null,
	maxCounterparties: 12,
	width: 900,
	height: 600,
	alpha: 0,
	running: false,
	db: null,
	loadTimer: null,
	lastLoaded: ''
}

document.addEventListener('DOMContentLoaded', init)

function init() {
	app.svg = document.getElementById('graph')
	app.edgesLayer = document.getElementById('edgesLayer')
	app.nodesLayer = document.getElementById('nodesLayer')
	document.getElementById('app-version').textContent = 'v' + app.version
	var address = document.getElementById('address')
	address.addEventListener('input', onAddressInput)
	address.addEventListener('keydown', onAddressKeydown)
	address.addEventListener('blur', onAddressBlur)
	document.getElementById('network').addEventListener('change', onControlsChange)
	document.getElementById('maxCounterparties').addEventListener('change', onControlsChange)
	var details = document.getElementById('details')
	details.addEventListener('change', onDetailsChange)
	details.addEventListener('click', onDetailsClick)
	openDb().then(handleDbOpen).catch(handleDbError)
}

function handleDbOpen() {
	dbGet('settings', 'seed', applySettings)
}

function applySettings(record) {
	if (record) {
		document.getElementById('address').textContent = record.address
		document.getElementById('network').value = record.network
		document.getElementById('maxCounterparties').value = record.maxCounterparties
	}
	loadGraph()
}

function handleDbError(error) {
	console.log('IndexedDB unavailable:', error)
	loadGraph()
}

// ------------------------------------------------------------------
// IndexedDB: one record per address, plus a settings store
// ------------------------------------------------------------------

function openDb() {
	return new Promise(executeOpenDb)
}

function executeOpenDb(resolve, reject) {
	var request = indexedDB.open('WalletGraph', 1)
	request.onupgradeneeded = upgradeDb
	request.onsuccess = handleSuccess
	request.onerror = handleError

	function upgradeDb(event) {
		var db = event.target.result
		if (!db.objectStoreNames.contains('addresses')) db.createObjectStore('addresses', {keyPath: 'address'})
		if (!db.objectStoreNames.contains('settings')) db.createObjectStore('settings', {keyPath: 'key'})
	}
	function handleSuccess(event) {
		app.db = event.target.result
		resolve(app.db)
	}
	function handleError(event) {
		reject(event.target.error)
	}
}

function dbGet(storeName, key, callback) {
	if (!app.db) return
	var request = app.db.transaction(storeName, 'readonly').objectStore(storeName).get(key)
	request.onsuccess = handleSuccess

	function handleSuccess() {
		callback(request.result)
	}
}

function dbPut(storeName, value) {
	if (!app.db) return
	app.db.transaction(storeName, 'readwrite').objectStore(storeName).put(value)
}

function saveAddressData(address, patch) {
	dbGet('addresses', address, mergeRecord)

	function mergeRecord(record) {
		if (!record) record = {address: address, name: ''}
		var keys = Object.keys(patch)
		for (var i = 0; i < keys.length; i++) {
			record[keys[i]] = patch[keys[i]]
		}
		record.updated = new Date().toISOString()
		dbPut('addresses', record)
	}
}

function saveSettings(address) {
	dbPut('settings', {key: 'seed', address: address, network: app.network, maxCounterparties: app.maxCounterparties})
}

// ------------------------------------------------------------------
// Controls: any change reloads the graph (no Load button)
// ------------------------------------------------------------------

function onAddressInput() {
	clearTimeout(app.loadTimer)
	app.loadTimer = setTimeout(loadGraph, 600)
}

function onAddressKeydown(event) {
	if (event.key === 'Enter') {
		event.preventDefault()
		event.target.blur()
	}
}

function onAddressBlur() {
	clearTimeout(app.loadTimer)
	loadGraph()
}

function onControlsChange() {
	loadGraph()
}

function getAddressText() {
	return document.getElementById('address').textContent.trim().toLowerCase()
}

function loadGraph() {
	var address = getAddressText()
	if (!/^0x[0-9a-f]{40}$/.test(address)) {
		if (document.activeElement !== document.getElementById('address')) {
			setStatus('That does not look like a valid address (0x followed by 40 hex characters).')
		}
		return
	}
	app.network = document.getElementById('network').value
	onMaxChange()
	var stamp = address + '|' + app.network + '|' + app.maxCounterparties
	if (stamp === app.lastLoaded) return
	app.lastLoaded = stamp
	saveSettings(address)
	saveAddressData(address, {network: app.network})
	loadSeed(address)
}

function onMaxChange() {
	var value = Number(document.getElementById('maxCounterparties').value)
	if (value >= 1 && value <= 50) app.maxCounterparties = value
}

function currentNetwork() {
	return NETWORKS[app.network]
}

// ------------------------------------------------------------------
// Fetch helpers
// ------------------------------------------------------------------

function get_json(url) {
	return fetch(url).then(parse_json)
}

function parse_json(response) {
	return response.json()
}

// ------------------------------------------------------------------
// Graph state
// ------------------------------------------------------------------

function loadSeed(address) {
	app.nodes = {}
	app.edges = {}
	app.selected = null
	app.edgesLayer.innerHTML = ''
	app.nodesLayer.innerHTML = ''
	addNode(address, app.width / 2, app.height / 2)
	selectNode(address)
	expandAddress(address)
	startSimulation()
}

function addNode(address, x, y) {
	var node = {
		address: address,
		name: '',
		x: x,
		y: y,
		vx: 0,
		vy: 0,
		expanded: false,
		loading: false,
		fixed: false,
		pinned: false,
		txCount: null,
		balance: null,
		hiddenCounterparties: 0
	}
	app.nodes[address] = node
	createNodeElement(node)
	dbGet('addresses', address, applyStored)
	return node

	function applyStored(record) {
		if (!record || !record.name) return
		node.name = record.name
		node.labelEl.textContent = node.name
		if (app.selected === address) updateDetails()
	}
}

function edgeKey(a, b) {
	return (a < b) ? a + '|' + b : b + '|' + a
}

function addOrUpdateEdge(a, b, count, value) {
	var key = edgeKey(a, b)
	if (!app.edges[key]) {
		app.edges[key] = {a: a, b: b, count: 0, value: 0}
		createEdgeElement(app.edges[key])
	}
	var edge = app.edges[key]
	edge.count = Math.max(edge.count, count)
	edge.value = Math.max(edge.value, value)
	edge.el.setAttribute('stroke-width', edgeWidth(edge.count))
	edge.titleEl.textContent = edge.count + ' transactions, ' + formatAmount(edge.value) + ' ' + currentNetwork().symbol
}

function edgeWidth(count) {
	return Math.min(1 + Math.log(count), 6)
}

// ------------------------------------------------------------------
// Expansion: fetch one address's transactions and add its counterparties
// ------------------------------------------------------------------

function expandAddress(address) {
	var node = app.nodes[address]
	if (!node || node.expanded || node.loading) return
	node.loading = true
	showNodeSpinner(node)
	setStatusLoading('Loading transactions for ' + shortAddress(address) + '…')
	var url = currentNetwork().api + '?module=account&action=txlist&address=' + address + '&sort=desc'
	get_json(url).then(handleTxList).catch(handleError)

	function handleTxList(response) {
		node.loading = false
		node.expanded = true
		hideNodeSpinner(node)
		var result = response.result
		if (!Array.isArray(result)) {
			node.txCount = 0
			setStatus('Explorer API: ' + (response.message || 'no transaction data returned.'))
			updateDetails()
			return
		}
		node.txCount = result.length
		saveAddressData(address, {txCount: node.txCount, network: app.network})
		var tally = {}
		for (var i = 0; i < result.length; i++) {
			var tx = result[i]
			if (!tx.to || !tx.from) continue
			var from = tx.from.toLowerCase()
			var to = tx.to.toLowerCase()
			var other = (from === address) ? to : from
			if (other === address) continue
			if (!tally[other]) tally[other] = {count: 0, value: 0}
			tally[other].count = tally[other].count + 1
			tally[other].value = tally[other].value + Number(tx.value) / 1e18
		}
		var others = Object.keys(tally)
		others.sort(compareTally)
		var kept = []
		for (var k = 0; k < others.length; k++) {
			if (k < app.maxCounterparties || app.nodes[others[k]]) kept.push(others[k])
		}
		node.hiddenCounterparties = others.length - kept.length
		for (var m = 0; m < kept.length; m++) {
			var otherAddress = kept[m]
			if (!app.nodes[otherAddress]) {
				var angle = Math.random() * Math.PI * 2
				addNode(otherAddress, node.x + Math.cos(angle) * 140, node.y + Math.sin(angle) * 140)
			}
			addOrUpdateEdge(address, otherAddress, tally[otherAddress].count, tally[otherAddress].value)
		}
		markExpanded(node)
		updateEdgeStyles()
		app.alpha = 1
		updateStatus()
		updateDetails()

		function compareTally(a, b) {
			return tally[b].count - tally[a].count
		}
	}

	function handleError(error) {
		node.loading = false
		hideNodeSpinner(node)
		setStatus('Could not reach the explorer API: ' + error.message)
	}
}

// ------------------------------------------------------------------
// Selection and details panel
// ------------------------------------------------------------------

function selectNode(address) {
	app.selected = address
	var keys = Object.keys(app.nodes)
	for (var i = 0; i < keys.length; i++) {
		var node = app.nodes[keys[i]]
		node.rectEl.setAttribute('stroke', (keys[i] === address) ? 'rgb(13, 110, 253)' : 'rgb(173, 181, 189)')
		node.rectEl.setAttribute('stroke-width', (keys[i] === address) ? 3 : 1.5)
	}
	updateDetails()
	fetchBalance(address)
}

function fetchBalance(address) {
	var node = app.nodes[address]
	if (!node || node.balance !== null) return
	var url = currentNetwork().api + '?module=account&action=balance&address=' + address
	get_json(url).then(handleBalance).catch(ignoreError)

	function handleBalance(response) {
		var result = Number(response.result) / 1e18
		if (!isNaN(result)) {
			node.balance = result
			saveAddressData(address, {balance: result})
			updateDetails()
		}
	}

	function ignoreError(error) {
		console.log('Balance lookup failed:', error.message)
	}
}

function onDetailsChange(event) {
	if (event.target.id === 'walletName') saveWalletName(event.target.value.trim())
}

function onDetailsClick(event) {
	if (event.target.id === 'btnUnpin') unpinSelected()
}

function saveWalletName(name) {
	var node = app.nodes[app.selected]
	if (!node) return
	node.name = name
	node.labelEl.textContent = name || shortAddress(node.address)
	saveAddressData(node.address, {name: name})
}

function unpinSelected() {
	var node = app.nodes[app.selected]
	if (!node) return
	node.pinned = false
	node.fixed = false
	updateEdgeStyles()
	app.alpha = 0.5
	updateDetails()
}

function updateDetails() {
	var panel = document.getElementById('details')
	var node = app.nodes[app.selected]
	if (!node) {
		panel.innerHTML = '<p class="text-secondary small mb-0">Click a wallet to see its details.</p>'
		return
	}
	var network = currentNetwork()
	var html = ''
	html += '<div class="d-flex align-items-start mb-2">'
	html += '<img class="blockie-large me-2" src="' + blockieDataUrl(node.address) + '" alt="blockie">'
	html += '<div class="details-address">' + node.address + '</div>'
	html += '</div>'
	html += '<label class="form-label small mb-1" for="walletName">Name</label>'
	html += '<input class="form-control form-control-sm mb-2" id="walletName" placeholder="Unnamed wallet" value="' + escapeHtml(node.name) + '">'
	if (node.balance !== null) {
		html += '<p class="mb-1"><strong>' + formatAmount(node.balance) + '</strong> ' + network.symbol + '</p>'
	}
	if (node.txCount !== null) {
		html += '<p class="mb-1 small">' + node.txCount + ' transactions fetched</p>'
	}
	if (node.hiddenCounterparties > 0) {
		html += '<p class="mb-1 small text-secondary">' + node.hiddenCounterparties + ' smaller counterparties not shown</p>'
	}
	if (node.loading) {
		html += '<p class="mb-1 small text-secondary"><span class="spinner-border spinner-border-sm me-1"></span>Loading&hellip;</p>'
	} else if (!node.expanded) {
		html += '<p class="mb-1 small text-secondary">Click again to expand this wallet.</p>'
	}
	if (node.pinned) {
		html += '<p class="mb-2"><button class="btn btn-outline-secondary btn-sm" id="btnUnpin" type="button">Release pin</button></p>'
	}
	html += '<a class="small" target="_blank" rel="noopener" href="' + network.explorer + '/address/' + node.address + '">View on explorer</a>'
	panel.innerHTML = html
}

function updateStatus() {
	var nodeCount = Object.keys(app.nodes).length
	var edgeCount = Object.keys(app.edges).length
	setStatus(nodeCount + ' wallets, ' + edgeCount + ' connections on ' + currentNetwork().label + '.')
}

function setStatus(text) {
	document.getElementById('status').textContent = text
}

function setStatusLoading(text) {
	document.getElementById('status').innerHTML = '<span class="spinner-border spinner-border-sm me-1"></span>' + text
}

// ------------------------------------------------------------------
// SVG elements
// ------------------------------------------------------------------

function svgEl(name) {
	return document.createElementNS('http://www.w3.org/2000/svg', name)
}

function createNodeElement(node) {
	var g = svgEl('g')
	g.dataset.address = node.address
	g.style.cursor = 'pointer'
	var rect = svgEl('rect')
	rect.setAttribute('x', -17)
	rect.setAttribute('y', -17)
	rect.setAttribute('width', 34)
	rect.setAttribute('height', 34)
	rect.setAttribute('rx', 6)
	rect.setAttribute('fill', 'white')
	rect.setAttribute('stroke', 'rgb(173, 181, 189)')
	rect.setAttribute('stroke-width', 1.5)
	var image = svgEl('image')
	image.setAttribute('href', blockieDataUrl(node.address))
	image.setAttribute('x', -14)
	image.setAttribute('y', -14)
	image.setAttribute('width', 28)
	image.setAttribute('height', 28)
	image.style.imageRendering = 'pixelated'
	var label = svgEl('text')
	label.setAttribute('y', 30)
	label.setAttribute('text-anchor', 'middle')
	label.setAttribute('font-size', 9)
	label.setAttribute('font-family', 'monospace')
	label.setAttribute('fill', 'rgb(73, 80, 87)')
	label.textContent = shortAddress(node.address)
	var title = svgEl('title')
	title.textContent = node.address
	g.appendChild(rect)
	g.appendChild(image)
	g.appendChild(label)
	g.appendChild(title)
	g.addEventListener('pointerdown', onNodePointerDown)
	app.nodesLayer.appendChild(g)
	node.el = g
	node.rectEl = rect
	node.labelEl = label
}

function markExpanded(node) {
	node.rectEl.setAttribute('fill', 'rgb(233, 245, 255)')
}

function showNodeSpinner(node) {
	if (node.spinnerEl) return
	var circle = svgEl('circle')
	circle.setAttribute('r', 24)
	circle.setAttribute('fill', 'none')
	circle.setAttribute('stroke', 'rgb(13, 110, 253)')
	circle.setAttribute('stroke-width', 3)
	circle.setAttribute('stroke-linecap', 'round')
	circle.setAttribute('stroke-dasharray', '30 121')
	var spin = svgEl('animateTransform')
	spin.setAttribute('attributeName', 'transform')
	spin.setAttribute('type', 'rotate')
	spin.setAttribute('from', '0')
	spin.setAttribute('to', '360')
	spin.setAttribute('dur', '0.8s')
	spin.setAttribute('repeatCount', 'indefinite')
	circle.appendChild(spin)
	node.el.appendChild(circle)
	node.spinnerEl = circle
}

function hideNodeSpinner(node) {
	if (!node.spinnerEl) return
	node.spinnerEl.remove()
	node.spinnerEl = null
}

function createEdgeElement(edge) {
	var line = svgEl('line')
	line.setAttribute('stroke', 'rgb(173, 181, 189)')
	line.setAttribute('stroke-width', 1)
	line.setAttribute('stroke-linecap', 'round')
	var title = svgEl('title')
	line.appendChild(title)
	app.edgesLayer.appendChild(line)
	edge.el = line
	edge.titleEl = title
}

function updateEdgeStyles() {
	var keys = Object.keys(app.edges)
	for (var i = 0; i < keys.length; i++) {
		var edge = app.edges[keys[i]]
		var relaxed = app.nodes[edge.a].pinned || app.nodes[edge.b].pinned
		edge.el.setAttribute('opacity', relaxed ? 0.4 : 1)
		if (relaxed) {
			edge.el.setAttribute('stroke-dasharray', '4 4')
		} else {
			edge.el.removeAttribute('stroke-dasharray')
		}
	}
}

// ------------------------------------------------------------------
// Pointer interaction: click selects and expands, drag pins and relaxes
// ------------------------------------------------------------------

function onNodePointerDown(event) {
	event.preventDefault()
	var address = event.currentTarget.dataset.address
	app.drag = {address: address, startX: event.clientX, startY: event.clientY, moved: false}
	app.nodes[address].fixed = true
	window.addEventListener('pointermove', onPointerMove)
	window.addEventListener('pointerup', onPointerUp)
}

function onPointerMove(event) {
	if (!app.drag) return
	var dx = event.clientX - app.drag.startX
	var dy = event.clientY - app.drag.startY
	if (Math.abs(dx) + Math.abs(dy) > 5) app.drag.moved = true
	if (!app.drag.moved) return
	var node = app.nodes[app.drag.address]
	var point = svgPoint(event)
	node.x = point.x
	node.y = point.y
	node.vx = 0
	node.vy = 0
	if (app.alpha < 0.3) app.alpha = 0.3
}

function onPointerUp(event) {
	if (!app.drag) return
	var address = app.drag.address
	var moved = app.drag.moved
	var node = app.nodes[address]
	app.drag = null
	window.removeEventListener('pointermove', onPointerMove)
	window.removeEventListener('pointerup', onPointerUp)
	if (moved) {
		node.pinned = true
		node.fixed = true
		updateEdgeStyles()
		if (app.selected === address) updateDetails()
	} else {
		node.fixed = false
		selectNode(address)
		expandAddress(address)
	}
}

function svgPoint(event) {
	var bounds = app.svg.getBoundingClientRect()
	var x = (event.clientX - bounds.left) / bounds.width * app.width
	var y = (event.clientY - bounds.top) / bounds.height * app.height
	return {x: x, y: y}
}

// ------------------------------------------------------------------
// Force-directed layout
// ------------------------------------------------------------------

function startSimulation() {
	app.alpha = 1
	if (app.running) return
	app.running = true
	requestAnimationFrame(tick)
}

function tick() {
	if (app.alpha > 0.005) {
		stepPhysics()
		app.alpha = app.alpha * 0.995
	}
	renderPositions()
	requestAnimationFrame(tick)
}

function stepPhysics() {
	var addresses = Object.keys(app.nodes)
	var i, j, node, other, dx, dy, distance, force

	// Repulsion between every pair of nodes
	for (i = 0; i < addresses.length; i++) {
		node = app.nodes[addresses[i]]
		for (j = i + 1; j < addresses.length; j++) {
			other = app.nodes[addresses[j]]
			dx = node.x - other.x
			dy = node.y - other.y
			distance = Math.sqrt(dx * dx + dy * dy) || 1
			force = (2600 / (distance * distance)) * app.alpha
			node.vx = node.vx + (dx / distance) * force
			node.vy = node.vy + (dy / distance) * force
			other.vx = other.vx - (dx / distance) * force
			other.vy = other.vy - (dy / distance) * force
		}
	}

	// Springs along edges; springs touching a pinned node go slack
	var edgeKeys = Object.keys(app.edges)
	for (i = 0; i < edgeKeys.length; i++) {
		var edge = app.edges[edgeKeys[i]]
		node = app.nodes[edge.a]
		other = app.nodes[edge.b]
		var slack = (node.pinned || other.pinned) ? 0.15 : 1
		dx = other.x - node.x
		dy = other.y - node.y
		distance = Math.sqrt(dx * dx + dy * dy) || 1
		force = (distance - 130) * 0.02 * app.alpha * slack
		node.vx = node.vx + (dx / distance) * force
		node.vy = node.vy + (dy / distance) * force
		other.vx = other.vx - (dx / distance) * force
		other.vy = other.vy - (dy / distance) * force
	}

	// Gentle pull toward the center, then integrate
	for (i = 0; i < addresses.length; i++) {
		node = app.nodes[addresses[i]]
		if (node.fixed) continue
		node.vx = node.vx + (app.width / 2 - node.x) * 0.005 * app.alpha
		node.vy = node.vy + (app.height / 2 - node.y) * 0.005 * app.alpha
		node.vx = node.vx * 0.85
		node.vy = node.vy * 0.85
		node.x = node.x + node.vx
		node.y = node.y + node.vy
		if (node.x < 30) node.x = 30
		if (node.x > app.width - 30) node.x = app.width - 30
		if (node.y < 30) node.y = 30
		if (node.y > app.height - 40) node.y = app.height - 40
	}
}

function renderPositions() {
	var addresses = Object.keys(app.nodes)
	for (var i = 0; i < addresses.length; i++) {
		var node = app.nodes[addresses[i]]
		node.el.setAttribute('transform', 'translate(' + node.x + ',' + node.y + ')')
	}
	var edgeKeys = Object.keys(app.edges)
	for (var k = 0; k < edgeKeys.length; k++) {
		var edge = app.edges[edgeKeys[k]]
		edge.el.setAttribute('x1', app.nodes[edge.a].x)
		edge.el.setAttribute('y1', app.nodes[edge.a].y)
		edge.el.setAttribute('x2', app.nodes[edge.b].x)
		edge.el.setAttribute('y2', app.nodes[edge.b].y)
	}
}

// ------------------------------------------------------------------
// Blockies: xmur3 hash, mulberry32 PRNG, HSL colors, mirrored grid
// ------------------------------------------------------------------

function xmur3(str) {
	var h = 1779033703 ^ str.length
	for (var i = 0; i < str.length; i++) {
		h = Math.imul(h ^ str.charCodeAt(i), 3432918353)
		h = (h << 13) | (h >>> 19)
	}
	return seed

	function seed() {
		h = Math.imul(h ^ (h >>> 16), 2246822507)
		h = Math.imul(h ^ (h >>> 13), 3266489909)
		h = (h ^ (h >>> 16)) >>> 0
		return h
	}
}

function mulberry32(a) {
	return rand

	function rand() {
		a = (a + 0x6D2B79F5) | 0
		var t = Math.imul(a ^ (a >>> 15), 1 | a)
		t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t
		return ((t ^ (t >>> 14)) >>> 0) / 4294967296
	}
}

function blockieDataUrl(address) {
	if (app.blockies[address]) return app.blockies[address]
	var seedFn = xmur3(address)
	var rand = mulberry32(seedFn())
	var color = 'hsl(' + Math.floor(rand() * 360) + ', 70%, 50%)'
	var bgcolor = 'hsl(' + Math.floor(rand() * 360) + ', 45%, 85%)'
	var spotcolor = 'hsl(' + Math.floor(rand() * 360) + ', 80%, 35%)'
	var size = 8
	var cells = []
	for (var y = 0; y < size; y++) {
		var row = []
		for (var x = 0; x < size / 2; x++) {
			row.push(Math.floor(rand() * 2.3))
		}
		var mirror = row.slice().reverse()
		cells.push(row.concat(mirror))
	}
	var canvas = document.createElement('canvas')
	canvas.width = size
	canvas.height = size
	var ctx = canvas.getContext('2d')
	ctx.fillStyle = bgcolor
	ctx.fillRect(0, 0, size, size)
	for (var cy = 0; cy < size; cy++) {
		for (var cx = 0; cx < size; cx++) {
			var value = cells[cy][cx]
			if (value === 0) continue
			ctx.fillStyle = (value === 1) ? color : spotcolor
			ctx.fillRect(cx, cy, 1, 1)
		}
	}
	var dataUrl = canvas.toDataURL()
	app.blockies[address] = dataUrl
	return dataUrl
}

// ------------------------------------------------------------------
// Formatting
// ------------------------------------------------------------------

function shortAddress(address) {
	return address.slice(0, 6) + '…' + address.slice(-4)
}

function formatAmount(value) {
	// toLocaleString with no locale argument uses the browser's locale,
	// so separators come out American or European automatically.
	return Math.round(value).toLocaleString()
}

function escapeHtml(text) {
	return String(text).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;')
}
