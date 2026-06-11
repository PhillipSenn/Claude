<cfscript>
	include '/Inc/cfm/YouTube.cfm'
	param name="url.videoid" default="";
	videoid = trim(url.videoid)

	cfcontent(type="application/json; charset=utf-8")

	if (NOT len(videoid) OR NOT len(apikey)) {
		writeOutput(serializeJSON({"title": "", "message": "Missing video ID or API key"}))
		abort
	}

	try {
		cfhttp(
			url     = "https://www.googleapis.com/youtube/v3/videos",
			method  = "get",
			result  = "httpResult",
			timeout = 10
		) {
			cfhttpparam(type="url", name="part", value="snippet")
			cfhttpparam(type="url", name="id",   value=videoid)
			cfhttpparam(type="url", name="key",  value=apikey)
		}

		if (httpResult.statusCode contains "200") {
			writeOutput(httpResult.fileContent)
		} else {
			writeOutput(serializeJSON({"title": "", "message": "API error: " & httpResult.statusCode}))
		}

	} catch (any e) {
		writeOutput(serializeJSON({"title": "", "message": e.message}))
	}
</cfscript>
