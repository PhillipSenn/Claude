var dom = dom || {} // Document Objet Model
var pgm = pgm || {} // Programs
var app = app || {} // Variables

//dom.id = $('[name=id]:first')

$('.nav-link').not($('nav .nav-link'))
	.wrap('<li class="nav-item"></li>')
$('.nav-item').not($('nav .nav-item')).appendTo('.navbar-nav')

$('table').not('.no-table').addClass('table')
$('.table').not('.no-border').addClass('table-bordered')
$('.table').not('.no-hover').addClass('table-hover')
$('.table').not('.no-sm').addClass('table-sm')
$('thead').not('.thead-dark').addClass('thead-light')

pgm.geturl = function(name) {
	var lstParams = location.href.slice(
		location.href.indexOf('?') + 1
	)
	var i = lstParams.indexOf('#')
	if (i > -1) {
		lstParams = lstParams.substr(0,i)
	}
	arrParams = lstParams.split('&')
	for(var i = 0; i < arrParams.length; i++)	{
		var arr = arrParams[i].split('=')
		if (arr[0].toUpperCase() === name.toUpperCase()) {
			return arr[1]
		}
	}
}
$('input:text,textarea,input[type=email],input[type=password],input[type=url]')
	.not('[hidden]')
	.not('.no-form-control')
	.addClass('form-control')
$('select').addClass('form-select')
pgm.autosize = function() {
	if (!$(this).hasClass('no-autosize')) {
		autosize(this)
	}
}
$('textarea').each(pgm.autosize)

$('form').attr('method','post')


pgm.selectAll = function() {
	var isChecked = $(this).is(':checked')
	$(this).closest('table').find('tbody :checkbox')
		.attr('checked',isChecked)
}
$(document).on('change','.selectAll',pgm.selectAll)

pgm.fail = function(xhr, status, response) {
	$('body').html('<p class="text-danger">' + status + ': ' + response + '</p>')
		.append(xhr.responseText)
}

pgm.eachTitle = function() {
	$(this).attr('data-bs-toggle','tooltip')
}
$('[title]').each(pgm.eachTitle)

pgm.tooltipList = function (response) {
	var params = {}
	params.placement = 'bottom'

	return new bootstrap.Tooltip(response,params)
}
//var tooltipList = tooltipTriggerList.map(pgm.tooltipList)
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
tooltipTriggerList.map(pgm.tooltipList)

pgm.submitted = function() {
	$(this).fadeTo('slow',.25)
}
$('form').submit(pgm.submitted)
pgm.autoSelect = function() {
	$(this).closest('form').submit()
}
$(document).on('change','select.autoSelect',pgm.autoSelect)


pgm.fixMojibake = function(response) {
	if (typeof response !== 'string') return response
	var result = response
		.replace(/Ã‚/g, '')
		.replace(/Â/g, '&nbsp;')
		.replace(/â€™/g, '’')
		.replace(/â€œ/g, '“')
		.replace(/â€�/g, '”')
		.replace(/â€“/g, '–')
		.replace(/â€”/g, '—')
		.replace(/â€¢/g, '•')
		.replace(/â€¦/g, '…')
		.replace(/â€˜/g, '‘')
		.replace(/â€/g, '')
		.replace(/â­�/g, '<i class="bi bi-fill text-warning"></i>')
		.replace(/â�/g, '')
		.replace(/Ä™/g, 'ę')
		.replace(/Å‚/g, 'ł')
		.replace(/Å„/g, 'ń')
		.replace(/Ã³/g, 'ó')
		.replace(/Å›/g, 'ś')
		.replace(/Å¼/g, 'ż')
		.replace(/Åº/g, 'ź')
		.replace(/Ä‡/g, 'ć')
	return result
}

pgm.filterTextNodes = function() {
	return this.nodeType === 3
}

pgm.updateHtmlFromTextNode = function() {
	dom.parentNode = $(this.parentNode)
	var oldHtml = dom.parentNode.html()
	var newHtml = pgm.fixMojibake(oldHtml)
	if (newHtml !== oldHtml) {
		dom.parentNode.html(newHtml)
	}
}

dom.contents = $('body').find('*').addBack().contents()
dom.textNodes = dom.contents.filter(pgm.filterTextNodes)
dom.textNodes.each(pgm.updateHtmlFromTextNode)


$('.card-header.alert-primary a').addClass('text-body fst-italic')


pgm.each_id = function() {
	var id = this.id
	var result = id.replace(/-/g, '_')
	dom[result] = $(this)
}

pgm.each_name = function() {
	var name = this.name
	var result = name.replace(/-/g, '_')

	if (dom.hasOwnProperty(result)) {
		dom[result] = dom[result].add($(this))
	} else {
		dom[result] = $(this)
	}
}

pgm.each_class = function() {
	var classAttr = $(this).attr('class')
	if (!classAttr) return

	var classList = classAttr.split(/\s+/)

	for (var i = 0; i < classList.length; i++) {
		var cls = classList[i]
		var result = cls.replace(/-/g, '_')

		if (dom.hasOwnProperty(result)) {
			dom[result] = dom[result].add($(this))
		} else {
			dom[result] = $(this)
		}
	}
}

$('[id]').each(pgm.each_id)
$('[name]').each(pgm.each_name)
$('[class]').each(pgm.each_class)
//console.log('dom',dom)

pgm.caught = function(response) {
	console.error(response)
	$('.card-header').text('Fetch error')
}

pgm.get_text = function(url) {
	return fetch(url)
		.then(pgm.done_text)
		.catch(pgm.caught)
}

pgm.post_text = function(url,form) {
	var params = {}
	params.method = 'post'
	params.headers = {
		'Content-Type': 'application/x-www-form-urlencoded'
	}
	params.body = new URLSearchParams(form).toString()
	return fetch(url, params)
		.then(pgm.done_text)
		.catch(pgm.caught)
}

pgm.done_text = function(response) {
	if (!response.ok) {
		console.log(response)
		throw new Error(response.status + ', ' + response.statusText) // Used in pgm.caught
	}
	return response.text()
}

$('section').addClass('card')
$('header').addClass('card-header')
$('article').addClass('card-body')
$('footer').addClass('card-footer')

pgm.btn_primary= function() {
	var self
	var variants = [
		'btn-primary','btn-secondary','btn-success','btn-danger',
		'btn-warning','btn-info','btn-light','btn-dark','btn-link',
		'btn-outline-primary','btn-outline-secondary','btn-outline-success',
		'btn-outline-danger','btn-outline-warning','btn-outline-info',
		'btn-outline-light','btn-outline-dark'
	]
	
	function each_btn() {
		self = $(this)
		if (!variants.some(isVariant)) {
			self.addClass('btn-primary')
		}
	}
	function isVariant(v) {
		return self.hasClass(v)
	}
	$('button').not('.btn-close').addClass('btn')
	$('.btn').each(each_btn)
}
pgm.btn_primary()

pgm.a_href = function() {
	$('a').each(each_a)
	function each_a() {
		var self = $(this)
		if (!self.attr('href')) {
			self.attr('href', 'JavaScript:')
		}
		if (self.attr('target')) {
		} else if (!this.host.length) {
		} else if (this.host != location.host) {
			self.attr('target','_blank')
		}
	}
}
pgm.a_href()
