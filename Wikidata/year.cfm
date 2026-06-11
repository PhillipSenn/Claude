<cfinclude template="/Inc/header.cfm">

<div class="container-fluid mt-4">

	<div class="row mb-3">
		<div class="col-12">
			<h1>Wikidata Year Events <small id="app-version" class="text-muted"></small></h1>
		</div>
	</div>

	<div class="row mb-3">
		<div class="col-md-4">
			<div class="input-group">
				<input type="number" id="year-input" class="form-control" placeholder="e.g. 1969" min="1" max="2100">
				<div class="input-group-append">
					<button id="fetch-btn" class="btn btn-primary">Search</button>
				</div>
			</div>
		</div>
	</div>

	<div id="loading" class="mb-3" style="display:none">
		<span class="spinner-border spinner-border-sm text-primary" role="status" aria-hidden="true"></span>
		<span class="text-muted ml-2">Querying Wikidata &mdash; this may take a few seconds&hellip;</span>
	</div>

	<div class="row">

		<div class="col-md-8">
			<div id="results-count" class="text-muted mb-3"></div>
			<div id="events-container" class="row"></div>
		</div>

		<div class="col-md-4">
			<div id="filters-area" style="display:none">
				<h6>Filter by Type <small class="text-muted">(P31)</small></h6>
				<div id="checkboxes-container"></div>
			</div>
		</div>

	</div>

</div>

<cfinclude template="/Inc/footer.cfm">
