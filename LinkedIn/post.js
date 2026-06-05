app.version = 8

var selectedTone = 'Authentic and personal'

function domContentLoaded() {
	document.getElementById('app-version').innerHTML = '&bull; v' + app.version
	setupDragDrop()
	document.getElementById('generated-post').addEventListener('input', updateCharCount)
}

window.addEventListener('DOMContentLoaded', domContentLoaded)

var imageFile = null
var imageDataUrl = null

function imageReaderOnload(e) {
	imageDataUrl = e.target.result
	document.getElementById('preview-img').src = imageDataUrl
	document.getElementById('image-preview').style.display = 'block'
}

function handleImageSelect(e) {
	var input = e.target
	if (!input.files || !input.files[0]) return
	imageFile = input.files[0]
	var reader = new FileReader()
	reader.onload = imageReaderOnload
	reader.readAsDataURL(imageFile)
}

function remove_img_btn() {
	imageFile = null
	imageDataUrl = null
	document.getElementById('image-preview').style.display = 'none'
	document.getElementById('image-input').value = ''
}

function setupDragDrop() {
	var drop = document.getElementById('image-drop')
	function dragOver(e) {
		e.preventDefault()
		drop.classList.add('drag-over')
	}
	function dragLeave() {
		drop.classList.remove('drag-over')
	}
	function dropHandler(e) {
		e.preventDefault()
		drop.classList.remove('drag-over')
		var files = e.dataTransfer.files
		if (files && files[0]) {
			imageFile = files[0]
			var reader = new FileReader()
			reader.onload = imageReaderOnload
			reader.readAsDataURL(imageFile)
		}
	}
	drop.addEventListener('dragover', dragOver)
	drop.addEventListener('dragleave', dragLeave)
	drop.addEventListener('drop', dropHandler)
}

function setStatus(msg, isError) {
	var bar = document.getElementById('status-bar')
	bar.style.display = 'block'
	bar.textContent = msg
	bar.className = isError ? 'error' : ''
}

function clearStatus() {
	document.getElementById('status-bar').style.display = 'none'
}

function generate_btn() {
	var topic = document.getElementById('topic-input').value.trim()
	if (!topic) { alert('Please describe what you want to talk about.'); return }

	var btn = document.getElementById('generate-btn')
	btn.disabled = true
	setStatus('Writing your post…')
	document.getElementById('output-section').style.display = 'none'

	var systemPrompt = [
		'You write LinkedIn posts for professionals.',
		'Write in first person. No hashtag spam — maximum 3 relevant hashtags at the end, or none at all.',
		'No emoji overload. Keep it human and real.',
		'Length: 150–400 words unless the topic warrants more.',
		'Do NOT include any preamble or meta-commentary. Output the post text only.'
	].join(' ')

	var prompt = 'System: ' + systemPrompt + '\n\nTopic: ' + topic + '\n\nTone: ' + selectedTone + '\n\nWrite the LinkedIn post now.'
	function done(data) {
		if (data.error) {
			setStatus('API error: ' + data.error.message, true)
			btn.disabled = false
			return
		}
		var result = data.content[0].text.trim()
		document.getElementById('generated-post').textContent = result
		updateCharCount()
		document.getElementById('output-section').style.display = 'block'
		clearStatus()
		document.getElementById('output-section').scrollIntoView({ behavior: 'smooth', block: 'start' })
		btn.disabled = false
	}

	function generateCatch(err) {
		setStatus('Error: ' + err.message, true)
		btn.disabled = false
	}

	post_json('/Inc/cfm/Anthropic.cfm', {
		model: 'claude-sonnet-4-6',
		max_tokens: 1000,
		messages: [{
			role: 'user',
			content: prompt
		}]
	}).then(done).catch(generateCatch)
}

function updateCharCount() {
	var post = document.getElementById('generated-post')
	var count = post.textContent.length
	var el = document.getElementById('char-count')
	el.textContent = count
	el.className = ''
	if (count > 2800) el.classList.add('warn')
	if (count > 3000) el.classList.add('over')
}

function save() {
	var postText = document.getElementById('generated-post').textContent.trim()
	if (!postText) { alert('No post text to send.'); return }

	this.disabled = true

	var statusBar = document.getElementById('status-bar')
	statusBar.style.display = 'block'
	statusBar.style.background = '#f0f8ff'
	statusBar.style.border = '1.5px solid #0a66c2'
	statusBar.style.color = '#0a4a8a'

	var payload = { text: postText, imageDataUrl: imageDataUrl || null, ts: Date.now() }
	localStorage.setItem('linkedin_post_payload', JSON.stringify(payload))

	statusBar.innerHTML = '✓ Post data saved. Opening LinkedIn…<br><small>The automation script will fill in your post. You click <strong>Post</strong>.</small>'

	window.open('https://www.linkedin.com/feed/?linkedinPostBuilder=1', '_blank')

	function linkedinTimeout() {
		statusBar.innerHTML = [
			'✓ LinkedIn opened in a new tab.<br>',
			'<small>',
			'Your post text is in your clipboard. Click <strong>Start a post</strong> and paste.',
			'</small>'
		].join('')
		btn.disabled = false
		if (navigator.clipboard) {
			navigator.clipboard.writeText(postText)
		}
	}

	setTimeout(linkedinTimeout, 1200)
}

$(document).on('change', '#image-input', handleImageSelect)
$(document).on('click', '#remove-img-btn', remove_img_btn)
$(document).on('click', '#generate-btn', generate_btn)
$(document).on('click', '#save', save)

$(document).on('click', '.tone-btn', tone_btn)

function tone_btn() {
	$('.tone-btn').removeClass('active')
	$(this).addClass('active')
	selectedTone = $(this).data('tone')
}
