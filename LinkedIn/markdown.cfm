<cfscript>
include '/Inc/header.cfm'
</cfscript>

<div class="card">
	<div class="card-header bg-primary-subtle d-flex justify-content-between align-items-center">
		<span>Markdown Formatter</span>
	</div>
	<div class="card-body">
		<textarea id="myText" class="form-control" rows="8" autofocus placeholder="Use **bold** and __italic__ markup..."></textarea>
		<div id="myPreview" class="mt-3 p-2 border rounded" style="min-height:3rem;"></div>
	</div>
	<div class="card-footer">
		<button class="btn btn-primary save-btn">Save</button>
	</div>
</div>
<a class="nav-link" href="#request.script_name#">Markdown</a>
<div class="nav-item">&bull; v4</div>
<script src="/Inc/js/autosize.js"></script>
<cfinclude template="/Inc/footer.cfm">
