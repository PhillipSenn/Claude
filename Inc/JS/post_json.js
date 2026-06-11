function caught(url) {
	function make_caught(error) {
		console.error('Fetch error for URL:', url)
		console.error('Status:', error.status || 'unknown')
		console.error('Message:', error.message)
		console.error('Stack:', error.stack)
//		$('.card-header').text('Fetch to ' + url + ' failed: ' + error.message)
		document.querySelector('.card-header').textContent = 'Fetch to ' + url + ' failed: ' + error.message
		document.getElementById('status-bar').textContent = url + ' failed: ' + error.message
	}
	return make_caught
}

function post_json(url, form) {
	var response = fetch(url, {
		 method: 'POST'
		,headers: { 'Content-Type': 'application/json' }
		,body: JSON.stringify(form)
	}).then(done)
		.catch(caught(url))
	return response
	function done(response) {
		if (!response.ok) {
			throw new Error('HTTP ' + response.status + ' ' + response.statusText)
		}
		return response.json()
	}
}
