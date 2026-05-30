<cfscript>
// proxy.cfm — Anthropic API proxy
// Keep this file on your server. Never expose your API key in frontend code.

apiKey = "YOUR_ANTHROPIC_API_KEY_HERE"
apiUrl = "https://api.anthropic.com/v1/messages"

// Only allow POST requests
if (cgi.request_method neq "POST") {
    cfheader(statuscode="405", statustext="Method Not Allowed")
    writeOutput('{"error":"Method not allowed"}')
    abort
}

// Read the raw request body sent by the browser
requestBody = toString(getHttpRequestData().content)

// Forward the request to Anthropic
cfhttp(method="post", url=apiUrl, result="anthropicResponse", charset="utf-8") {
    cfhttpparam(type="header", name="Content-Type",      value="application/json")
    cfhttpparam(type="header", name="x-api-key",         value=apiKey)
    cfhttpparam(type="header", name="anthropic-version", value="2023-06-01")
    cfhttpparam(type="body",   value=requestBody)
}

// Return Anthropic's response as-is to the browser
cfheader(name="Content-Type", value="application/json")
writeOutput(anthropicResponse.filecontent)
</cfscript>
