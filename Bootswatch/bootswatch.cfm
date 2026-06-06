<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Bootswatch Theme Switcher</title>
	<link id="themeCSS" rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.css">
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
		<div class="container">
			<a class="navbar-brand" href="#">Bootswatch</a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="mainNav">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#">About</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Services</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
				</ul>
				<div class="d-flex align-items-center gap-2">
					<label class="text-white mb-0" for="themeSelect">Theme:</label>
					<select id="themeSelect" class="form-select form-select-sm" style="width:180px" onchange="switchTheme()">
						<option value="">Bootstrap (default)</option>
						<option value="cerulean">Cerulean</option>
						<option value="cosmo">Cosmo</option>
						<option value="cyborg">Cyborg</option>
						<option value="darkly">Darkly</option>
						<option value="flatly">Flatly</option>
						<option value="journal">Journal</option>
						<option value="litera">Litera</option>
						<option value="lumen">Lumen</option>
						<option value="lux">Lux</option>
						<option value="materia">Materia</option>
						<option value="minty">Minty</option>
						<option value="morph">Morph</option>
						<option value="pulse">Pulse</option>
						<option value="quartz">Quartz</option>
						<option value="sandstone">Sandstone</option>
						<option value="simplex">Simplex</option>
						<option value="sketchy">Sketchy</option>
						<option value="slate">Slate</option>
						<option value="solar">Solar</option>
						<option value="spacelab">Spacelab</option>
						<option value="superhero">Superhero</option>
						<option value="united">United</option>
						<option value="vapor">Vapor</option>
						<option value="yeti">Yeti</option>
						<option value="zephyr">Zephyr</option>
					</select>
				</div>
			</div>
		</div>
	</nav>

	<div class="container">

		<!--- Display Headings --->
		<section class="mb-5">
			<h2 class="mb-3">Display Headings</h2>
			<p class="display-1">Display 1</p>
			<p class="display-2">Display 2</p>
			<p class="display-3">Display 3</p>
			<p class="display-4">Display 4</p>
			<p class="display-5">Display 5</p>
			<p class="display-6">Display 6</p>
		</section>

		<!--- Typography --->
		<section class="mb-5">
			<h2 class="mb-3">Typography</h2>
			<h1>Heading 1</h1>
			<h2>Heading 2</h2>
			<h3>Heading 3</h3>
			<h4>Heading 4</h4>
			<h5>Heading 5</h5>
			<h6>Heading 6</h6>
			<p class="lead">This is a lead paragraph. It stands out from regular body text.</p>
			<p>Regular body text. Bootstrap includes global settings for typography, including <strong>bold</strong>, <em>italic</em>, and <a href="#">linked</a> text.</p>
			<p class="text-muted">Muted using <code>.text-muted</code>.</p>
			<p class="text-body-secondary">Body secondary using <code>.text-body-secondary</code>.</p>
			<p class="text-body-tertiary">Body tertiary using <code>.text-body-tertiary</code>.</p>
			<p class="text-body-emphasis">Body emphasis using <code>.text-body-emphasis</code>.</p>
			<p class="text-primary">Primary using <code>.text-primary</code>.</p>
			<p class="text-primary-emphasis">Primary emphasis using <code>.text-primary-emphasis</code>.</p>
			<p class="text-success">Success using <code>.text-success</code>.</p>
			<p class="text-success-emphasis">Success emphasis using <code>.text-success-emphasis</code>.</p>
			<p class="text-danger">Danger using <code>.text-danger</code>.</p>
			<p class="text-danger-emphasis">Danger emphasis using <code>.text-danger-emphasis</code>.</p>
			<p class="text-warning">Warning using <code>.text-warning</code>.</p>
			<p class="text-warning-emphasis">Warning emphasis using <code>.text-warning-emphasis</code>.</p>
			<p class="text-info">Info using <code>.text-info</code>.</p>
			<p class="text-info-emphasis">Info emphasis using <code>.text-info-emphasis</code>.</p>
			<p><mark>Highlighted text</mark> and <small>small text</small> and <del>deleted text</del>.</p>
			<blockquote class="blockquote">
				<p>A well-known quote, contained in a blockquote element.</p>
				<footer class="blockquote-footer">Someone famous in <cite>Source Title</cite></footer>
			</blockquote>
		</section>

		<!--- Subtle Backgrounds --->
		<section class="mb-5">
			<h2 class="mb-3">Subtle Backgrounds</h2>
			<div class="p-3 mb-2 bg-primary-subtle text-primary-emphasis rounded"><code>.bg-primary-subtle</code> with <code>.text-primary-emphasis</code></div>
			<div class="p-3 mb-2 bg-secondary-subtle text-secondary-emphasis rounded"><code>.bg-secondary-subtle</code> with <code>.text-secondary-emphasis</code></div>
			<div class="p-3 mb-2 bg-success-subtle text-success-emphasis rounded"><code>.bg-success-subtle</code> with <code>.text-success-emphasis</code></div>
			<div class="p-3 mb-2 bg-danger-subtle text-danger-emphasis rounded"><code>.bg-danger-subtle</code> with <code>.text-danger-emphasis</code></div>
			<div class="p-3 mb-2 bg-warning-subtle text-warning-emphasis rounded"><code>.bg-warning-subtle</code> with <code>.text-warning-emphasis</code></div>
			<div class="p-3 mb-2 bg-info-subtle text-info-emphasis rounded"><code>.bg-info-subtle</code> with <code>.text-info-emphasis</code></div>
			<div class="p-3 mb-2 bg-light-subtle text-body-emphasis rounded border"><code>.bg-light-subtle</code> with <code>.text-body-emphasis</code></div>
			<div class="p-3 mb-2 bg-dark-subtle text-dark-emphasis rounded"><code>.bg-dark-subtle</code> with <code>.text-dark-emphasis</code></div>
		</section>

		<!--- Buttons --->
		<section class="mb-5">
			<h2 class="mb-3">Buttons</h2>
			<div class="mb-3">
				<button type="button" class="btn btn-primary me-2">Primary</button>
				<button type="button" class="btn btn-secondary me-2">Secondary</button>
				<button type="button" class="btn btn-success me-2">Success</button>
				<button type="button" class="btn btn-danger me-2">Danger</button>
				<button type="button" class="btn btn-warning me-2">Warning</button>
				<button type="button" class="btn btn-info me-2">Info</button>
				<button type="button" class="btn btn-light me-2">Light</button>
				<button type="button" class="btn btn-dark me-2">Dark</button>
			</div>
			<div class="mb-3">
				<button type="button" class="btn btn-outline-primary me-2">Outline Primary</button>
				<button type="button" class="btn btn-outline-secondary me-2">Outline Secondary</button>
				<button type="button" class="btn btn-outline-success me-2">Outline Success</button>
				<button type="button" class="btn btn-outline-danger me-2">Outline Danger</button>
				<button type="button" class="btn btn-outline-warning me-2">Outline Warning</button>
				<button type="button" class="btn btn-outline-info me-2">Outline Info</button>
			</div>
			<div>
				<button type="button" class="btn btn-primary btn-lg me-2">Large</button>
				<button type="button" class="btn btn-primary me-2">Default</button>
				<button type="button" class="btn btn-primary btn-sm me-2">Small</button>
				<button type="button" class="btn btn-primary" disabled>Disabled</button>
			</div>
		</section>

		<!--- Cards --->
		<section class="mb-5">
			<h2 class="mb-3">Cards</h2>
			<div class="row g-4">
				<div class="col-md-4">
					<div class="card h-100">
						<div class="card-header">Featured</div>
						<div class="card-body">
							<h5 class="card-title">Card Title</h5>
							<h6 class="card-subtitle mb-2 text-muted">Card Subtitle</h6>
							<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
							<a href="#" class="btn btn-primary">Go somewhere</a>
						</div>
						<div class="card-footer text-muted">2 days ago</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card h-100 border-success">
						<div class="card-body">
							<h5 class="card-title text-success">Success Card</h5>
							<p class="card-text">This card uses a success border and title color to convey a positive state.</p>
							<a href="#" class="btn btn-success">Learn More</a>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="card h-100 bg-primary text-white">
						<div class="card-body">
							<h5 class="card-title">Colored Card</h5>
							<p class="card-text">Cards can use background and text color utilities to change their appearance entirely.</p>
							<a href="#" class="btn btn-light">Action</a>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!--- Alerts --->
		<section class="mb-5">
			<h2 class="mb-3">Alerts</h2>
			<div class="alert alert-primary">A primary alert — check it out!</div>
			<div class="alert alert-success">A success alert — great work!</div>
			<div class="alert alert-warning">A warning alert — watch out!</div>
			<div class="alert alert-danger">A danger alert — something went wrong!</div>
			<div class="alert alert-info">An informational alert — heads up!</div>
		</section>

		<!--- Badges & Pills --->
		<section class="mb-5">
			<h2 class="mb-3">Badges</h2>
			<p>
				<span class="badge bg-primary me-1">Primary</span>
				<span class="badge bg-secondary me-1">Secondary</span>
				<span class="badge bg-success me-1">Success</span>
				<span class="badge bg-danger me-1">Danger</span>
				<span class="badge bg-warning text-dark me-1">Warning</span>
				<span class="badge bg-info text-dark me-1">Info</span>
			</p>
			<p>
				<span class="badge rounded-pill bg-primary me-1">Primary</span>
				<span class="badge rounded-pill bg-secondary me-1">Secondary</span>
				<span class="badge rounded-pill bg-success me-1">Success</span>
				<span class="badge rounded-pill bg-danger me-1">Danger</span>
			</p>
		</section>

	</div><!--- /container --->

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.js"></script>
	<script src="bootswatch.js"></script>

</body>
</html>
