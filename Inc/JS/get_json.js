function caught(url) {
	function make_caught(error) {
		console.error('Fetch error for URL:', url)
		console.error('Status:', error.status || 'unknown')
		console.error('Message:', error.message)
		console.error('Stack:', error.stack)
		document.querySelector('.card-header').textContent = 'Fetch to ' + url + ' failed: ' + error.message
		document.getElementById('status-bar').textContent = url + ': ' + error.message
	}
	return make_caught
}

function get_json(url) {
	var response = fetch(url).then(done)
		.catch(caught(url))
	return response
	function done(response) {
		if (!response.ok) {
			throw new Error('HTTP ' + response.status + ' ' + response.statusText)
		}
		return response.json()
	}
}
