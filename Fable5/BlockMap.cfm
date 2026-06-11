<cfscript>
include '/Inc/header.cfm'
</cfscript>
<link rel="stylesheet" href="maplibre-gl.css">
<link rel="stylesheet" href="BlockMap.css">

<div class="container-fluid mt-2">
	<div class="row">
		<div class="col-md-9">
			<div id="MapWrapper"></div>
			<p class="text-muted small mt-1 mb-0">
				Pan: move mouse to the edge of the map &middot;
				Zoom: scroll wheel &middot;
				Rotate: Q / E (or right-click drag) &middot;
				Click a building to identify it &middot;
				Esc clears the selection
			</p>
		</div>
		<div class="col-md-3">
			<div class="input-group mb-2">
				<input type="search" class="form-control" id="place-search" aria-label="Search">
				<button class="btn btn-outline-secondary" type="button" id="place-search-btn" title="Search">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
						<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
					</svg>
				</button>
			</div>
			<div class="card">
				<div class="card-header bg-primary-subtle">
					<h5 id="place-name" class="mb-0">Selected Place</h5>
				</div>
				<div class="card-body">
					<p class="text-muted" id="place-empty">Click a building on the map.</p>
					<div id="place-details" class="d-none">
						<address id="place-address"></address>
						<p id="place-rating" class="mb-2"></p>
						<div id="place-types"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<a class="nav-link active">Block Maps</a>
<a class="nav-item" id="app-version"></a>
<script src="maplibre-gl-dev.js"></script>
<!--- Google is only used for Places (identify + search); the map itself is MapLibre + OpenFreeMap (no key needed) --->
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDANepu-lH6R_zOf5llZgr9XBQojEGfFSQ&v=beta&libraries=places&callback=init_map"></script>
<cfinclude template="/Inc/footer.cfm">
