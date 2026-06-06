function switchTheme() {
	var select = document.getElementById("themeSelect")
	var theme = select.value
	var link = document.getElementById("themeCSS")
	if (theme === "") {
		link.href = "https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.css"
	} else {
		link.href = "https://cdn.jsdelivr.net/npm/bootswatch@5/dist/" + theme + "/bootstrap.css"
	}
}
