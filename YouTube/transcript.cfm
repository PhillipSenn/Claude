<cfscript>
	param name="url.videoid" default="";
	videoid = trim(url.videoid)
	cfcontent(type="application/json; charset=utf-8")

	if (NOT len(videoid)) {
		writeOutput(serializeJSON({"captionUrl": "", "message": "No videoid provided"}))
		abort
	}

	userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

	try {
		cfhttp(
			url       = "https://www.youtube.com/watch?v=" & videoid,
			method    = "get",
			result    = "pageResult",
			timeout   = 15,
			useragent = userAgent
		) {
			cfhttpparam(type="header", name="Accept-Language", value="en-US,en;q=0.9")
		}

		if (NOT pageResult.statusCode contains "200") {
			writeOutput(serializeJSON({"captionUrl": "", "message": "Could not load watch page: " & pageResult.statusCode}))
			abort
		}

		pageHtml = pageResult.fileContent

		captionTracksPos = find('"captionTracks"', pageHtml)
		if (captionTracksPos EQ 0) {
			writeOutput(serializeJSON({"captionUrl": "", "message": "captionTracks not found in page"}))
			abort
		}

		baseUrlMarker = '"baseUrl":"'
		captionUrl    = ""
		fallbackUrl   = ""
		searchPos     = captionTracksPos

		// Walk through all baseUrl entries after captionTracks, prefer lang=en
		while (searchPos LT len(pageHtml)) {
			baseUrlPos = find(baseUrlMarker, pageHtml, searchPos)
			if (baseUrlPos EQ 0) {
				break
			}
			urlStart = baseUrlPos + len(baseUrlMarker)
			urlEnd   = find('"', pageHtml, urlStart) - 1
			thisUrl  = mid(pageHtml, urlStart, urlEnd - urlStart + 1)

			// Stop if we have drifted outside captionTracks into another section
			if (NOT thisUrl contains "timedtext") {
				break
			}

			if (NOT len(fallbackUrl)) {
				fallbackUrl = thisUrl
			}
			if (thisUrl contains "lang=en") {
				captionUrl = thisUrl
				break
			}
			searchPos = urlEnd + 1
		}

		if (NOT len(captionUrl)) {
			captionUrl = fallbackUrl
		}

		if (NOT len(captionUrl)) {
			writeOutput(serializeJSON({"captionUrl": "", "message": "No caption URL found"}))
			abort
		}

		// Return the raw URL — JavaScript will decode & → & via JSON.parse automatically
		// We output as a plain string value so serializeJSON handles escaping correctly
		writeOutput('{"captionUrl":' & serializeJSON(captionUrl) & '}')

	} catch (any e) {
		writeOutput(serializeJSON({"captionUrl": "", "message": e.message}))
	}
</cfscript>
