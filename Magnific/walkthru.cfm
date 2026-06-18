<cfscript>
request.container = 'container-fluid'
include '/Inc/header.cfm'
</cfscript>

<div class="row">
	<div class="col">
		<canvas id="gameCanvas" width="800" height="400"></canvas>
		<p>Press &#8592; &#8594; arrow keys to walk</p>
	</div>
	<div class="col">
		<img src="walkthru.png">
	</div>
</div>
<a class="nav-link">Walk-thru</a>
<a class="nav-item" id="app-version"></a>
<cfinclude template="/Inc/footer.cfm">
