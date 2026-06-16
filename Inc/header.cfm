<cfscript>
param request.cache='';
param request.cache = '?cache=' & TimeFormat(now(),'Hmmss');
param request.container = 'container-xxl';
param request.title = 'PhillipSenn.com';
//param request.navbar = request.container & ' sticky-top';
param request.navbar = request.container;
param request.ico = '/favicon.ico';
param request.script_name = cgi.script_name;
if (Len(cgi.query_string)) {
	request.script_name &= '?' & cgi.query_string
}
param request.top = 'sticky-top';
param request.top = '';
request.cgiName	= getPageContext().getRequest().getServletPath()
request.serverDir	= getDirectoryFromPath(request.cgiName)
request.serverFile= getFileFromPath(request.cgiName)
request.pgmDir		= ExpandPath(request.serverDir)
request.pgmName	= Left(request.serverFile,Len(request.serverFile)-4)
</cfscript>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<cfscript>
//<link	rel="icon" href="' & request.ico & '">
WriteOutput('<meta	name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.css">
<link	rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@latest/font/bootstrap-icons.css">
<link	rel="stylesheet" href="/Inc/css/header.css' & request.cache & '">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.js"></script>' & chr(10))
if (fileExists(request.pgmDir & request.pgmName & '.css')) {
	writeoutput('<link	href="' & request.pgmName & '.css' & request.cache & '" rel="stylesheet">' & chr(10))
}
writeoutput('<script src="https://cdn.jsdelivr.net/npm/jquery@4/dist/jquery.js"></script>' & chr(10))
if (IsDefined('request.jqueryui')) {
	writeoutput('<link	rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.14.1/themes/smoothness/jquery-ui.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.14.1/jquery-ui.js"></script>' & chr(10))
}
writeoutput('<title>' & request.title & '</title>' & chr(10))
</cfscript>
</head>
<body>
<div class="<cfoutput>#request.container# #request.top#</cfoutput>">
	<nav class="navbar navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
		<a class="bi bi-house-fill link-secondary me-1 ps-4" href="/"></a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav">
			</ul>
		</div>
	</nav>
	<cfif structKeyExists(form,'actid')>
		<cfset act = new dbo.proc().usr('act.where_act',form.actid)>
		<cfoutput>
		<div class="progress">
			<div id="progress_nav" class="progress-bar bg-primary" role="progressbar" 
				style="width: #act.earned#%;" 
				aria-valuenow="#act.earned#" 
				aria-valuemin="0" 
				aria-valuemax="100">
				<cfif val(act.earned)>#act.earned#%</cfif>
			</div>
		</div>
		<input type="hidden" id="actid" value="#act.actid#">
		</cfoutput>
	</cfif>
</div>
<main class="<cfoutput>#request.container#</cfoutput> mb-5 pb-5">
