<cfoutput>
<cfinclude template="/Inc/header.cfm">
<div id="progress-wrap" class="sticky-top">
	<div class="progress">
	<div id="discovery-bar" class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">0%</div>
	</div>
	<p id="progress-label"></p>
</div>
<h1 class="text-center">Periodic Table of Elements</h1>
<p class="subtitle text-center">Hover over each category to earn points &mdash; discover all 10 to reach 100!</p>


<div id="table-wrap">
	<div id="periodic-table"></div>
</div>

<div id="legend"></div>
<a href="#request.script_name#" class="nav-link active">Periodic Table of Elements</a>
<span class="ps-0 nav-link" id="app-version"></span>
<cfinclude template="/footer.cfm">
<cfinclude template="/Inc/footer.cfm">
</cfoutput>