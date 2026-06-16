<cfinclude template="/Inc/header.cfm">

<div class="sticky-top">
	<div class="progress" style="height:1.25rem;border-radius:0;">
		<div class="progress-bar" id="painting-progress" role="progressbar" style="width:0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
	</div>
</div>
<button type="button" class="btn btn-primary btn-previous float-start">&laquo; Previous</button>
<button type="button" class="btn btn-primary btn-next float-end">Next &raquo;</button>
<div class="row justify-content-center">
	<div class="col-lg-8">
		<div class="card">
			<div class="card-header sticky-top bg-white" style="top:1.25rem;">
				<h1 class="h4 mb-0" id="painting-title">Loading&hellip;</h1>
			</div>
			<div class="card-body text-center">
				<img id="painting-image" class="img-fluid" src="" alt="">
			</div>
			<div class="card-footer">
				<div id="painting-description" class="mb-3"></div>
				<dl class="row mb-3" id="painting-attributes"></dl>
				<div class="d-flex justify-content-between align-items-center">
					<button type="button" class="btn btn-primary btn-previous">&laquo; Previous</button>
					<span id="painting-counter" class="text-muted"></span>
					<button type="button" class="btn btn-primary btn-next">Next &raquo;</button>
				</div>
			</div>
		</div>
	</div>
</div>
<a class="nav-link active">Rijksmuseum</a>
<a class="nav-item" id="app-version"></a>
<cfinclude template="/Inc/footer.cfm">
