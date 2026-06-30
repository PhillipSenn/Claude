<cfscript>
request.title = 'The Front Page — Historic Newspaper Search'
include '/Inc/header.cfm'
</cfscript>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400&family=IBM+Plex+Mono:wght@400;500&family=Source+Serif+4:wght@400;600&display=swap" rel="stylesheet">
<header class="masthead">
	<div class="masthead-rule"></div>
	<div class="masthead-inner container">
		<div class="edition-line">
			<span class="edition-tag">Est. 1756</span>
			<span class="edition-tag">Library of Congress · Chronicling America</span>
			<span class="edition-tag" id="todayDate"></span>
		</div>
		<h1 class="masthead-title">The Front Page</h1>
		<p class="masthead-sub">Search millions of digitized historic American newspapers &mdash; 1756 to 1963</p>
	</div>
	<div class="masthead-rule thick"></div>
</header>

<section class="search-bar-section">
	<div class="container">
		<div class="row g-2 align-items-end justify-content-center">
			<div class="col-12 col-md-4">
				<label class="search-label" for="searchKeyword">Keyword or phrase</label>
				<input type="text" id="searchKeyword" class="form-control search-input" placeholder="e.g. &ldquo;armistice&rdquo; or &ldquo;moon landing&rdquo;">
			</div>
			<div class="col-6 col-md-2">
				<label class="search-label" for="startDate">From</label>
				<input type="date" id="startDate" class="form-control search-input" value="1920-01-01" min="1756-01-01" max="1963-12-31">
			</div>
			<div class="col-6 col-md-2">
				<label class="search-label" for="endDate">To</label>
				<input type="date" id="endDate" class="form-control search-input" value="1920-12-31" min="1756-01-01" max="1963-12-31">
			</div>
			<div class="col-12 col-md-2">
				<label class="search-label" for="stateFilter">State</label>
				<select id="stateFilter" class="form-select search-input">
					<option value="">All States</option>
					<option>Alabama</option><option>Alaska</option><option>Arizona</option>
					<option>Arkansas</option><option>California</option><option>Colorado</option>
					<option>Connecticut</option><option>Delaware</option><option>Florida</option>
					<option>Georgia</option><option>Hawaii</option><option>Idaho</option>
					<option>Illinois</option><option>Indiana</option><option>Iowa</option>
					<option>Kansas</option><option>Kentucky</option><option>Louisiana</option>
					<option>Maine</option><option>Maryland</option><option>Massachusetts</option>
					<option>Michigan</option><option>Minnesota</option><option>Mississippi</option>
					<option>Missouri</option><option>Montana</option><option>Nebraska</option>
					<option>Nevada</option><option>New Hampshire</option><option>New Jersey</option>
					<option>New Mexico</option><option>New York</option><option>North Carolina</option>
					<option>North Dakota</option><option>Ohio</option><option>Oklahoma</option>
					<option>Oregon</option><option>Pennsylvania</option><option>Rhode Island</option>
					<option>South Carolina</option><option>South Dakota</option><option>Tennessee</option>
					<option>Texas</option><option>Utah</option><option>Vermont</option>
					<option>Virginia</option><option>Washington</option><option>West Virginia</option>
					<option>Wisconsin</option><option>Wyoming</option>
				</select>
			</div>
			<div class="col-12 col-md-2">
				<button id="btnSearch" class="btn btn-search w-100" onClick="runSearch()">Search Issues</button>
			</div>
		</div>
	</div>
</section>

<section class="results-section container mt-4">
	<div id="resultsHeader" class="results-header d-none">
		<span id="resultCount" class="result-count"></span>
		<span id="resultQuery" class="result-query"></span>
	</div>
	<div id="resultsGrid" class="row g-4 mt-1"></div>
	<div id="loadMoreBar" class="text-center mt-4 d-none">
		<button id="btnLoadMore" class="btn btn-outline-load" onClick="loadMore()">Load more issues</button>
	</div>
	<div id="emptyState" class="empty-state d-none">
		<p class="empty-headline">No issues found.</p>
		<p class="empty-sub">Try broader dates, a different keyword, or remove the state filter.</p>
	</div>
	<div id="loadingState" class="loading-state d-none">
		<div class="spinner-border text-sepia" role="status"></div>
		<p class="loading-label mt-3">Searching the archives&hellip;</p>
	</div>
</section>

<footer class="site-footer mt-5">
	<div class="container text-center">
		<p>Data provided by <a href="https://www.loc.gov/collections/chronicling-america/" target="_blank">Chronicling America</a> &mdash; Library of Congress &middot; National Endowment for the Humanities</p>
		<p class="footer-note">Front pages only &middot; Coverage: 1756&ndash;1963 &middot; No API key required</p>
	</div>
</footer>

<a class="nav-link" href="#request.script_name#">#actname#</a>
<cfinclude template="/Inc/footer.cfm">
