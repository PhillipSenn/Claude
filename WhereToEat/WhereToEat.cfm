<cfinclude template="/Inc/header.cfm">

<div class="container">

	<div id="status" class="alert alert-info">Loading Google Maps&hellip;</div>

	<div id="restaurant-area" class="d-none">

		<div class="d-flex justify-content-between align-items-center mb-3">
			<button type="button" id="prev-btn" class="btn btn-outline-primary">&laquo; Previous</button>
			<span id="counter" class="text-muted"></span>
			<button type="button" id="next-btn" class="btn btn-outline-primary">Next &raquo;</button>
		</div>

		<div class="row">
			<div class="col-md-8 mb-3">
				<div class="card h-100">
					<div class="card-header">
						<h4 id="restaurant-name" class="mb-0"></h4>
					</div>
					<div class="card-body">
						<p id="summary" class="lead d-none"></p>
						<div id="photos" class="row g-2"></div>
					</div>
					<div class="card-footer" id="info"></div>
				</div>
			</div>
			<div class="col-md-4 mb-3">
				<div class="card h-100">
					<div class="card-header">
						<h5 class="mb-0">Location</h5>
					</div>
					<div class="card-body">
						<p id="distance" class="mb-0"></p>
						<details id="hours" class="d-none mt-2">
							<summary>Hours</summary>
							<ul id="hours-list" class="list-unstyled small mb-0 mt-1"></ul>
						</details>
					</div>
					<div class="card-footer" id="address"></div>
				</div>
			</div>
		</div>

	</div>

</div>
<a class="nav-link active">Where to eat</a>
<a class="nav-item" id="app-version"></a>

<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDcqJkSPe3OL4BD2Eqr5hSMd1P3ICxcRuU&v=weekly&libraries=places&callback=init_map"></script>
<cfinclude template="/Inc/footer.cfm">
