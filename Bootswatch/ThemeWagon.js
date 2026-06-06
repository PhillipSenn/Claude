var app = {}
app.version = 1

document.getElementById('app-version').textContent = 'v' + app.version

function switchTemplate() {
	var select = document.getElementById('templateSelect')
	var frame = document.getElementById('previewFrame')
	var placeholder = document.getElementById('placeholder')
	var downloadLink = document.getElementById('downloadLink')
	var newTabLink = document.getElementById('newTabLink')
	var selectedOption = select.options[select.selectedIndex]
	var url = select.value
	var dlUrl = selectedOption.getAttribute('data-dl') || 'https://themewagon.com/theme-framework/bootstrap-5/'

	if (url === '') {
		frame.classList.add('d-none')
		placeholder.classList.remove('d-none')
		downloadLink.href = 'https://themewagon.com/theme-framework/bootstrap-5/'
		newTabLink.classList.add('d-none')
	} else {
		frame.src = url
		frame.classList.remove('d-none')
		placeholder.classList.add('d-none')
		downloadLink.href = dlUrl
		newTabLink.href = url
		newTabLink.classList.remove('d-none')
	}
}

document.getElementById('templateSelect').addEventListener('change', switchTemplate)
