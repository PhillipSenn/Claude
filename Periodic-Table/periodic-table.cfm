<cfoutput>
<cfinclude template="/Inc/header.cfm">
<h1 class="text-center">Periodic Table of Elements</h1>
<p class="subtitle text-center">Hover over an element to highlight its category</p>

<div id="table-wrap">
	<div id="periodic-table"></div>
</div>

<div id="legend"></div>
<a href="#request.script_name#" class="nav-link active">Periodic Table of Elements</a>
<span class="ps-0 nav-link" id="app-version"></span>
<cfinclude template="/footer.cfm">
<cfinclude template="/Inc/footer.cfm">
</cfoutput>