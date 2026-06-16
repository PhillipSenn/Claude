<cfscript>
param request.cache = '?cache=' & TimeFormat(now(),'Hmmss');
request.cache=''
request.cgiName		= getPageContext().getRequest().getServletPath()
//writeoutput('<div hidden>cgiName: ' & cgiName & '</div>
//<div hidden>scriptName: ' & cgi.SCRIPT_NAME & '</div>')
request.serverDir	= getDirectoryFromPath(request.cgiName)
request.serverFile= getFileFromPath(request.cgiName)
request.pgmDir		= ExpandPath(request.serverDir)
request.pgmName	= Left(request.serverFile,Len(request.serverFile)-4)
writeoutput('</main>' & chr(10))
writeoutput('<script src="/Inc/js/footer.js' & request.cache & '"></script>' & chr(10))
if (fileExists(request.pgmDir & request.pgmName & '.js')) {
	writeoutput('<script src="' & request.pgmName & '.js' & request.cache & '"></script>')
}
</cfscript>
</body>
</html>