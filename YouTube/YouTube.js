var app = {}
app.version = 23

var ytPlayer
var currentVideoId = ''
var watchedSeconds = {}     // [startSec, endSec) only — drives % complete
var allWatchedSeconds = {}  // every second ever played — drives segment table
var startSec = 0
var endSec = 0
var segmentLength = 0
var pollInterval = null
var transcriptEvents = []
var lastSyncIndex = -1
var pendingVideoId = null
var resumedPastEnd = false
var questions = []
var currentParseQ = null    // temp used by each_hiddenChild

// YouTube IFrame API requires this exact global name
window.onYouTubeIframeAPIReady = youtubeApiReady

$(document).ready(docReady)

function docReady() {
	document.getElementById('app-version').textContent = 'v' + app.version
	$(document).on('submit', '#video-form', handleFormSubmit)
	$(document).on('click', '#resume-btn', handleResume)
	$(document).on('click', '.transcript-line', handleTranscriptClick)
	$(document).on('click', '#modal-submit-btn', handleModalSubmit)
	$(window).on('blur', handleWindowBlur)
	$(window).on('beforeunload', handleBeforeUnload)
	$(document).on('visibilitychange', handleVisibilityChange)
	$('#video-form').trigger('submit')
}

// ─── YouTube API ──────────────────────────────────────────────

function youtubeApiReady() {
	if (pendingVideoId) {
		createPlayer(pendingVideoId)
		pendingVideoId = null
	}
}

function loadYouTubeApiScript() {
	if (document.getElementById('yt-api-script')) return
	var tag = document.createElement('script')
	tag.id = 'yt-api-script'
	tag.src = 'https://www.youtube.com/iframe_api'
	document.head.appendChild(tag)
}

function createPlayer(videoId) {
	currentVideoId = videoId
	ytPlayer = new YT.Player('yt-player', {
		width: '100%',
		height: '100%',
		playerVars: {
			autoplay: 0,
			controls: 1,
			rel: 0,
			modestbranding: 1
		},
		events: {
			onReady: handlePlayerReady,
			onStateChange: handlePlayerStateChange
		}
	})
}

function handlePlayerReady() {
	ytPlayer.cueVideoById({videoId: currentVideoId, startSeconds: startSec})
	setupIntersectionObserver()
}

// ─── Form ─────────────────────────────────────────────────────

function handleFormSubmit(e) {
	e.preventDefault()
	var videoId = $('#video-id').val().trim()
	startSec = parseInt($('#start-sec').val(), 10) || 0
	endSec = parseInt($('#end-sec').val(), 10) || 0

	if (!videoId) return
	if (endSec > 0 && endSec <= startSec) {
		alert('End seconds must be greater than start seconds')
		return
	}

	segmentLength = endSec > 0 ? endSec - startSec : 0
	currentVideoId = videoId
	watchedSeconds = {}
	allWatchedSeconds = {}
	resumedPastEnd = false
	lastSyncIndex = -1
	transcriptEvents = []

	parseQuestions()

	$('#resume-btn').hide()
	$('#watched-segments').hide()
	$('#segments-tbody').empty()
	$('#transcript-panel').hide()
	$('#transcript-container').empty()
	$('#video-title').text('')
	$('#video-description').hide().text('')

	if (endSec > 0) {
		$('#segment-label').text('Segment: ' + formatTime(startSec) + ' – ' + formatTime(endSec) + ' (' + segmentLength + 's)')
	} else {
		$('#segment-label').text('Start: ' + formatTime(startSec))
	}

	updateProgress()
	loadVideoMetadata(videoId)
	loadTranscript(videoId)

	if (ytPlayer && ytPlayer.cueVideoById) {
		ytPlayer.cueVideoById({videoId: videoId, startSeconds: startSec})
	} else if (window.YT && window.YT.Player) {
		createPlayer(videoId)
	} else {
		pendingVideoId = videoId
		loadYouTubeApiScript()
	}
}

// ─── Player state ─────────────────────────────────────────────

function handlePlayerStateChange(event) {
	if (event.data === YT.PlayerState.PLAYING) {
		// If the user pressed play via the built-in controls while at or past
		// endSec, treat it the same as clicking the custom Resume button
		if (endSec > 0 && ytPlayer.getCurrentTime() >= endSec) {
			resumedPastEnd = true
			$('#resume-btn').hide()
		}
		startPolling()
	} else if (event.data === YT.PlayerState.ENDED) {
		stopPolling()
		// endSec=0 means no boundary — show no-timestamp questions at video end
		if (endSec === 0) {
			var pendingQ = findPendingNoTimestampQuestion()
			if (pendingQ !== -1) {
				showQuestionModal(pendingQ)
			}
		}
	} else {
		stopPolling()
	}
}

function startPolling() {
	if (pollInterval) return
	pollInterval = setInterval(pollPlayer, 500)
}

function stopPolling() {
	if (pollInterval) {
		clearInterval(pollInterval)
		pollInterval = null
	}
}

function pollPlayer() {
	if (!ytPlayer || !ytPlayer.getCurrentTime) return
	var currentTime = ytPlayer.getCurrentTime()
	var sec = Math.floor(currentTime)

	// Check mid-video question triggers before anything else
	if (checkQuestionTriggers(currentTime)) return

	// Reached end of graded segment — pause unless user already resumed past it
	if (!resumedPastEnd && endSec > 0 && currentTime >= endSec) {
		ytPlayer.pauseVideo()
		stopPolling()
		var pendingQ = findPendingNoTimestampQuestion()
		if (pendingQ !== -1) {
			showQuestionModal(pendingQ)
		} else {
			$('#resume-btn').show()
		}
		return
	}

	// Track every second played for the segment table
	allWatchedSeconds[sec] = true
	updateSegmentTable()

	// Track [startSec, endSec) for % complete
	if (segmentLength > 0 && currentTime >= startSec && sec < endSec) {
		watchedSeconds[sec] = true
		updateProgress()
	}

	syncTranscript(currentTime)
}

function updateProgress() {
	if (segmentLength <= 0) return
	var watched = Object.keys(watchedSeconds).length
	var pct = Math.min(100, Math.round(watched / segmentLength * 100))
	$('#progress-bar')
		.css('width', pct + '%')
		.attr('aria-valuenow', pct)
		.text(pct + '%')
	$('#pct-label').text(pct + '% complete (' + watched + ' / ' + segmentLength + ' sec)')
}

// ─── Resume ───────────────────────────────────────────────────

function handleResume() {
	$('#resume-btn').hide()
	resumedPastEnd = true
	if (ytPlayer && ytPlayer.playVideo) {
		ytPlayer.playVideo()
	}
}

// ─── Focus / visibility ───────────────────────────────────────

function handleWindowBlur() {
	pauseIfPlaying()
}

function handleBeforeUnload() {
	pauseIfPlaying()
}

function setupIntersectionObserver() {
	if (!window.IntersectionObserver) return
	var target = document.querySelector('.video-responsive')
	if (!target) return
	var observer = new IntersectionObserver(handleIntersectionEntries, {threshold: 0.1})
	observer.observe(target)
}

function handleIntersectionEntries(entries) {
	$.each(entries, each_intersectionEntry)
}

function each_intersectionEntry(i, entry) {
	if (!entry.isIntersecting) {
		pauseIfPlaying()
	}
}

function handleVisibilityChange() {
	if (document.hidden) {
		pauseIfPlaying()
	}
}

function pauseIfPlaying() {
	if (!ytPlayer || !ytPlayer.getPlayerState) return
	if (ytPlayer.getPlayerState() === YT.PlayerState.PLAYING) {
		ytPlayer.pauseVideo()
	}
}

// ─── Video metadata ───────────────────────────────────────────

function loadVideoMetadata(videoId) {
	get_json('metadata.cfm?videoid=' + encodeURIComponent(videoId))
		.then(handleMetadataSuccess)
}

function handleMetadataSuccess(response) {
	var result = response.items && response.items[0]
	if (!result) return
	var snippet = result.snippet
	$('#video-title').text(snippet.title)
	if (snippet.description) {
		$('#video-description').text(snippet.description).show()
	}
}


// ─── Transcript ───────────────────────────────────────────────

function loadTranscript(videoId) {
	get_json('transcript.cfm?videoid=' + encodeURIComponent(videoId))
		.then(handleTranscriptUrlSuccess)
}

function handleTranscriptUrlSuccess(response) {
	if (!response || !response.captionUrl || !response.captionUrl.length) return
	// Decode any literal & sequences that survived double-escaping
	var captionUrl = response.captionUrl.replace(/\\u0026/g, '&') + '&fmt=json3'
	fetch(captionUrl)
		.then(parseFetchResponse)
		.then(handleTranscriptSuccess)
		.catch(handleTranscriptError)
}

function parseFetchResponse(res) {
	return res.json()
}

function handleTranscriptSuccess(data) {
	if (!data || !data.events || data.events.length === 0) return
	transcriptEvents = data.events.filter(transcriptEventHasText)
	if (transcriptEvents.length === 0) return
	renderTranscript()
	$('#transcript-panel').show()
}

function transcriptEventHasText(ev) {
	return ev.segs && ev.segs.length > 0
}

function handleTranscriptError(response) {
	console.log(response)
	// Transcript unavailable — panel stays hidden
}

function renderTranscript() {
	$('#transcript-container').empty()
	$.each(transcriptEvents, each_transcriptEvent)
}

function each_transcriptEvent(i, ev) {
	var text = $.map(ev.segs, mapSegText).join('')
	if (!text.trim()) return
	var startTime = ev.tStartMs / 1000
	var $time = $('<span>').addClass('transcript-time badge badge-secondary mr-1').text(formatTime(startTime))
	var $text = $('<span>').text(text)
	var $line = $('<div>')
		.addClass('transcript-line')
		.attr('data-index', i)
		.attr('data-start', startTime)
	$line.append($time).append($text)
	$('#transcript-container').append($line)
}

function mapSegText(seg) {
	return seg.utf8 || ''
}

function handleTranscriptClick() {
	var self = $(this)
	var startTime = parseFloat(self.attr('data-start'))
	if (!isNaN(startTime) && ytPlayer && ytPlayer.seekTo) {
		ytPlayer.seekTo(startTime, true)
		ytPlayer.playVideo()
	}
}

// ─── Transcript sync ──────────────────────────────────────────

function syncTranscript(currentTime) {
	if (transcriptEvents.length === 0) return

	var activeIndex = -1
	for (var i = 0; i < transcriptEvents.length; i++) {
		if (transcriptEvents[i].tStartMs / 1000 <= currentTime) {
			activeIndex = i
		} else {
			break
		}
	}

	if (activeIndex === lastSyncIndex) return
	lastSyncIndex = activeIndex

	$('.transcript-line').removeClass('active')
	if (activeIndex < 0) return

	var $line = $('.transcript-line[data-index="' + activeIndex + '"]')
	$line.addClass('active')

	var container = $('#transcript-container')[0]
	if (container && $line[0]) {
		container.scrollTop = $line[0].offsetTop - (container.offsetHeight / 2)
	}
}

// ─── Segment table ────────────────────────────────────────────

function updateSegmentTable() {
	var secs = Object.keys(allWatchedSeconds).map(Number).sort(sortNumeric)
	if (secs.length === 0) {
		$('#watched-segments').hide()
		return
	}
	var segs = buildSegments(secs)
	$('#watched-segments').show()
	$('#segments-tbody').empty()
	$.each(segs, each_segment)
}

function sortNumeric(a, b) {
	return a - b
}

function buildSegments(secs) {
	var result = [{start: secs[0], end: secs[0]}]
	for (var i = 1; i < secs.length; i++) {
		if (secs[i] <= result[result.length - 1].end + 1) {
			result[result.length - 1].end = secs[i]
		} else {
			result.push({start: secs[i], end: secs[i]})
		}
	}
	return result
}

function each_segment(i, seg) {
	var duration = seg.end - seg.start + 1
	var $row = $('<tr>')
		.append($('<td>').text(formatTime(seg.start)))
		.append($('<td>').text(formatTime(seg.end + 1)))
		.append($('<td>').text(duration + 's'))
	$('#segments-tbody').append($row)
}

// ─── Questions ────────────────────────────────────────────────

function parseQuestions() {
	questions = []
	currentParseQ = null
	$('#question-data').children().each(each_hiddenChild)
	currentParseQ = null
}

function each_hiddenChild() {
	var self = $(this)
	if (self.hasClass('q')) {
		var ts = self.attr('data-ts')
		currentParseQ = {
			text: self.text().trim(),
			timestamp: ts ? parseInt(ts, 10) : null,
			answers: [],
			answered: false
		}
		questions.push(currentParseQ)
	} else if (self.hasClass('ans') && currentParseQ) {
		currentParseQ.answers.push(self.text().trim())
	}
}

function checkQuestionTriggers(currentTime) {
	for (var i = 0; i < questions.length; i++) {
		var q = questions[i]
		if (!q.answered && q.timestamp !== null && currentTime >= q.timestamp) {
			ytPlayer.pauseVideo()
			stopPolling()
			showQuestionModal(i)
			return true
		}
	}
	return false
}

function findPendingNoTimestampQuestion() {
	for (var i = 0; i < questions.length; i++) {
		if (!questions[i].answered && questions[i].timestamp === null) {
			return i
		}
	}
	return -1
}

function showQuestionModal(qIndex) {
	var q = questions[qIndex]
	$('#modal-question-text').text(q.text)
	var $body = $('#modal-answers').empty()
	for (var i = 0; i < q.answers.length; i++) {
		var radioId = 'q-ans-' + i
		var $div = $('<div>').addClass('form-check')
		var $radio = $('<input>')
			.addClass('form-check-input')
			.attr({type: 'radio', name: 'q-answer', id: radioId, value: i})
		var $label = $('<label>')
			.addClass('form-check-label')
			.attr('for', radioId)
			.text(q.answers[i])
		$div.append($radio).append($label)
		$body.append($div)
	}
	$('#modal-submit-btn').data('qindex', qIndex)
	$('#question-modal').modal('show')
}

function handleModalSubmit() {
	var selected = $('input[name="q-answer"]:checked')
	if (selected.length === 0) {
		alert('Please select an answer.')
		return
	}
	var qIndex = $('#modal-submit-btn').data('qindex')
	questions[qIndex].answered = true
	$('#question-modal').modal('hide')

	// Check for another pending no-timestamp question at the end boundary
	var atEnd = endSec > 0 && ytPlayer && ytPlayer.getCurrentTime() >= endSec
	if (atEnd) {
		var nextQ = findPendingNoTimestampQuestion()
		if (nextQ !== -1) {
			showQuestionModal(nextQ)
			return
		}
		$('#resume-btn').show()
	} else {
		// Mid-video question — resume playback
		if (ytPlayer && ytPlayer.playVideo) {
			ytPlayer.playVideo()
		}
	}
}

// ─── Helpers ──────────────────────────────────────────────────

function formatTime(seconds) {
	var s = Math.floor(seconds)
	var m = Math.floor(s / 60)
	var rem = s % 60
	return m + ':' + (rem < 10 ? '0' : '') + rem
}
