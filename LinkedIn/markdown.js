$(document).ready(documentReady)

function documentReady() {
	$(document).on('click', '.save-btn', saveBtn)
}

function toBold(text) {
	var result = ''
	var i, code
	for (i = 0; i < text.length; i++) {
		code = text.charCodeAt(i)
		if (code >= 65 && code <= 90) {
			result += String.fromCodePoint(code - 65 + 0x1D400)
		} else if (code >= 97 && code <= 122) {
			result += String.fromCodePoint(code - 97 + 0x1D41A)
		} else if (code >= 48 && code <= 57) {
			result += String.fromCodePoint(code - 48 + 0x1D7CE)
		} else {
			result += text[i]
		}
	}
	return result
}

function toItalic(text) {
	var result = ''
	var i, code
	for (i = 0; i < text.length; i++) {
		code = text.charCodeAt(i)
		if (code >= 65 && code <= 90) {
			result += String.fromCodePoint(code - 65 + 0x1D434)
		} else if (code >= 97 && code <= 122) {
			if (code === 104) {
				result += 'ℎ'
			} else {
				result += String.fromCodePoint(code - 97 + 0x1D44E)
			}
		} else {
			result += text[i]
		}
	}
	return result
}

function applyBold(match, inner) {
	return toBold(inner)
}

function applyItalic(match, inner) {
	return toItalic(inner)
}

function saveBtn() {
	var raw = $('#myText').val()
	var result = raw
		.replace(/\*\*(.+?)\*\*/gs, applyBold)
		.replace(/__(.+?)__/gs, applyItalic)
		.replace(/<(?:strong|b)>([\s\S]+?)<\/(?:strong|b)>/gi, applyBold)
		.replace(/<(?:em|i)>([\s\S]+?)<\/(?:em|i)>/gi, applyItalic)
	$('#myPreview').text(result)
	navigator.clipboard.writeText(result).then(clipboardSuccess, clipboardError)
}

function clipboardSuccess() {
	var self = $('.save-btn')
	var original = self.text()
	self.text('Copied!').prop('disabled', true)
	setTimeout(function() {
		self.text(original).prop('disabled', false)
	}, 2000)
}

function clipboardError() {
	alert('Could not copy to clipboard.')
}
