var paragraphs = []
var currentParagraph = 0
var cursorOffset = -1

function isLetter(ch) {
	return /[a-zA-Z]/.test(ch)
}

function pickRandomLetterIndex(text) {
	var letterIndices = []
	for (var i = 0; i < text.length; i++) {
		if (isLetter(text.charAt(i))) {
			letterIndices.push(i)
		}
	}
	if (letterIndices.length === 0) {
		return -1
	}
	return letterIndices[Math.floor(Math.random() * letterIndices.length)]
}

function getParagraphs() {
	var result = []
	$('#reading-passage p').each(each_p)
	return result

	function each_p() {
		result.push($(this).text().trim())
	}
}

function escapeHtml(text) {
	return text
		.replace(/&/g, '&amp;')
		.replace(/</g, '&lt;')
		.replace(/>/g, '&gt;')
}

function setCurrentParagraph(startIndex) {
	currentParagraph = startIndex
	while (currentParagraph < paragraphs.length) {
		cursorOffset = pickRandomLetterIndex(paragraphs[currentParagraph])
		if (cursorOffset !== -1) {
			return
		}
		currentParagraph = currentParagraph + 1
	}
}

function findWordBounds(text, index) {
	var start = index
	while (start > 0 && isLetter(text.charAt(start - 1))) {
		start = start - 1
	}
	var end = index + 1
	while (end < text.length && isLetter(text.charAt(end))) {
		end = end + 1
	}
	return { start: start, end: end }
}

function renderCurrentParagraph(text) {
	var wordBounds = findWordBounds(text, cursorOffset)
	var beforeWord = text.slice(0, wordBounds.start)
	var wordBefore = text.slice(wordBounds.start, cursorOffset)
	var wordAfter  = text.slice(cursorOffset + 1, wordBounds.end)
	var afterWord  = text.slice(wordBounds.end)
	return '<p>' + escapeHtml(beforeWord)
		+ '<span class="reading-cursor-word">'
		+ escapeHtml(wordBefore)
		+ '<span id="reading-cursor" class="reading-cursor"></span>'
		+ '<span class="text-muted">' + escapeHtml(wordAfter) + '</span>'
		+ '</span>'
		+ '<span class="text-muted">' + escapeHtml(afterWord) + '</span>'
		+ '</p>'
}

function render() {
	var html = ''
	for (var i = 0; i < paragraphs.length; i++) {
		if (i < currentParagraph) {
			html += '<p>' + escapeHtml(paragraphs[i]) + '</p>'
		} else if (i === currentParagraph) {
			html += renderCurrentParagraph(paragraphs[i])
		} else {
			html += '<p class="text-muted">' + escapeHtml(paragraphs[i]) + '</p>'
		}
	}
	$('#reading-passage').html(html)
}

function updateProgress() {
	var percent = Math.round(currentParagraph / paragraphs.length * 100)
	$('#reading-progress').css('width', percent + '%')
	$('#reading-progress').text(percent + '%')
}

function handleReadingKeydown(event) {
	if (currentParagraph >= paragraphs.length) {
		return
	}
	if (event.altKey || event.ctrlKey || event.metaKey) {
		return
	}
	if (event.key.length !== 1) {
		return
	}
	event.preventDefault()
	var targetChar = paragraphs[currentParagraph].charAt(cursorOffset)
	if (event.key.toLowerCase() === targetChar.toLowerCase()) {
		advanceParagraph()
	} else {
		showCursorError()
	}
}

function advanceParagraph() {
	setCurrentParagraph(currentParagraph + 1)
	render()
	updateProgress()
	if (currentParagraph >= paragraphs.length) {
		scrollToBottom()
	} else {
		scrollCursorIntoView()
	}
}

function scrollCursorIntoView() {
	var cursor = document.getElementById('reading-cursor')
	if (cursor) {
		cursor.scrollIntoView({ block: 'nearest', behavior: 'smooth' })
	}
}

function scrollToBottom() {
	window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' })
}

function showCursorError() {
	$('#reading-cursor').addClass('reading-cursor-error')
	setTimeout(removeCursorError, 250)
}

function removeCursorError() {
	$('#reading-cursor').removeClass('reading-cursor-error')
}

paragraphs = getParagraphs()
setCurrentParagraph(0)
render()
updateProgress()
$(document).on('keydown', handleReadingKeydown)
