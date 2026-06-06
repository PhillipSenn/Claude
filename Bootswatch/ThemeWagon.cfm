<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>ThemeWagon Free Bootstrap 5 Templates</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.css">
	<style>
		body { display: flex; flex-direction: column; height: 100vh; margin: 0; }
		#previewFrame { flex: 1; border: none; width: 100%; }
		.template-label { font-size: .85rem; }
	</style>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="https://themewagon.com/theme-framework/bootstrap-5/" target="_blank">ThemeWagon</a>
			<div class="d-flex align-items-center gap-2 ms-auto">
				<label class="text-white mb-0 template-label" for="templateSelect">Template:</label>
				<select id="templateSelect" class="form-select form-select-sm" style="width:220px">
					<option value="">— pick a template —</option>
					<optgroup label="Business &amp; Corporate">
						<option value="https://themewagon.github.io/Dewi/" data-dl="https://themewagon.com/themes/dewi/">Dewi</option>
						<option value="https://themewagon.github.io/Company/" data-dl="https://themewagon.com/themes/company/">Company</option>
						<option value="https://themewagon.github.io/KnightOne/" data-dl="https://themewagon.com/themes/knightone/">KnightOne</option>
						<option value="https://themewagon.github.io/HeroBiz/" data-dl="https://themewagon.com/themes/herobiz/">HeroBiz</option>
						<option value="https://themewagon.github.io/BizLand/" data-dl="https://themewagon.com/themes/bizland/">BizLand</option>
						<option value="https://themewagon.github.io/Presento/" data-dl="https://themewagon.com/themes/presento/">Presento</option>
						<option value="https://themewagon.github.io/FlexStart/" data-dl="https://themewagon.com/themes/flexstart/">FlexStart</option>
						<option value="https://themewagon.github.io/OnePage/" data-dl="https://themewagon.com/themes/onepage/">OnePage</option>
						<option value="https://themewagon.github.io/Sailor/" data-dl="https://themewagon.com/themes/sailor/">Sailor</option>
						<option value="https://themewagon.github.io/Nova-Bootstrap/" data-dl="https://themewagon.com/themes/nova-bootstrap/">Nova</option>
						<option value="https://themewagon.github.io/monoline/" data-dl="https://themewagon.com/themes/monoline/">Monoline</option>
						<option value="https://themewagon.github.io/Business/" data-dl="https://themewagon.com/themes/business/">Business</option>
						<option value="https://themewagon.github.io/eNno/" data-dl="https://themewagon.com/themes/enno/">eNno</option>
						<option value="https://themewagon.github.io/logis-new/" data-dl="https://themewagon.com/themes/logis/">Logis</option>
						<option value="https://themewagon.github.io/Salone/" data-dl="https://themewagon.com/themes/salone/">Salone</option>
						<option value="https://themewagon.github.io/Weldork/" data-dl="https://themewagon.com/themes/weldork/">Weldork</option>
					</optgroup>
					<optgroup label="Admin &amp; Dashboard">
						<option value="https://themewagon.github.io/Mantis-Bootstrap/dashboard/index.html" data-dl="https://themewagon.com/themes/mantis/">Mantis</option>
						<option value="https://themewagon.github.io/dasher/" data-dl="https://themewagon.com/themes/dasher/">Dasher</option>
						<option value="https://themewagon.github.io/flexy-bootstrap-lite/" data-dl="https://themewagon.com/themes/flexy/">Flexy</option>
						<option value="https://themewagon.github.io/inapp/" data-dl="https://themewagon.com/themes/inapp/">InApp</option>
						<option value="https://themewagon.github.io/adminhmd/html/" data-dl="https://themewagon.com/themes/adminhmd/">AdminHMD</option>
					</optgroup>
					<optgroup label="Landing Pages &amp; SaaS">
						<option value="https://themewagon.github.io/Bliss/" data-dl="https://themewagon.com/themes/bliss/">Bliss</option>
						<option value="https://themewagon.github.io/SaaSintro/" data-dl="https://themewagon.com/themes/saasintro/">SaaSIntro</option>
						<option value="https://themewagon.github.io/SaaSpal/" data-dl="https://themewagon.com/themes/saaspal/">SaaSpal</option>
						<option value="https://themewagon.github.io/Appvila/" data-dl="https://themewagon.com/themes/appvila/">AppVila</option>
						<option value="https://themewagon.github.io/nexusai/" data-dl="https://themewagon.com/themes/nexusai/">NexusAI</option>
					</optgroup>
					<optgroup label="Education">
						<option value="https://themewagon.github.io/Mentor/" data-dl="https://themewagon.com/themes/mentor/">Mentor</option>
						<option value="https://themewagon.github.io/learnhub/index.html" data-dl="https://themewagon.com/themes/learnhub/">LearnHub</option>
						<option value="https://themewagon.github.io/purdue/" data-dl="https://themewagon.com/themes/purdue/">Purdue</option>
						<option value="https://themewagon.github.io/eduleb" data-dl="https://themewagon.com/themes/edulab/">Eduleb</option>
					</optgroup>
					<optgroup label="Medical">
						<option value="https://themewagon.github.io/MediLab/" data-dl="https://themewagon.com/themes/medilab/">MediLab</option>
						<option value="https://themewagon.github.io/MediCio/" data-dl="https://themewagon.com/themes/medicio/">MediCio</option>
						<option value="https://themewagon.github.io/Clinic/" data-dl="https://themewagon.com/themes/clinic/">Clinic</option>
						<option value="https://themewagon.github.io/Medinova/" data-dl="https://themewagon.com/themes/medinova/">Medinova</option>
						<option value="https://themewagon.github.io/primeDental/index.html" data-dl="https://themewagon.com/themes/prime-dental/">PrimeDental</option>
						<option value="https://themewagon.github.io/Plasery/" data-dl="https://themewagon.com/themes/plasery/">Plasery</option>
					</optgroup>
					<optgroup label="eCommerce">
						<option value="https://themewagon.github.io/Electro-Bootstrap/" data-dl="https://themewagon.com/themes/electro-bootstrap/">Electro</option>
						<option value="https://themewagon.github.io/furnish/" data-dl="https://themewagon.com/themes/furnish/">Furnish</option>
					</optgroup>
					<optgroup label="Portfolio &amp; Agency">
						<option value="https://themewagon.github.io/Kelly/" data-dl="https://themewagon.com/themes/kelly/">Kelly</option>
						<option value="https://themewagon.github.io/Poseify/" data-dl="https://themewagon.com/themes/poseify/">Poseify</option>
						<option value="https://themewagon.github.io/iStudio/" data-dl="https://themewagon.com/themes/istudio/">iStudio</option>
						<option value="https://themewagon.github.io/Charitize/" data-dl="https://themewagon.com/themes/charitize/">Charitize</option>
						<option value="https://themewagon.github.io/Flat/" data-dl="https://themewagon.com/themes/flat/">Flat</option>
						<option value="https://themewagon.github.io/Studiova/html/" data-dl="https://themewagon.com/themes/studiova/">Studiova</option>
					</optgroup>
					<optgroup label="Restaurant &amp; Fitness">
						<option value="https://themewagon.github.io/yummy-red/" data-dl="https://themewagon.com/themes/yummy-red/">Yummy</option>
						<option value="https://themewagon.github.io/sarab/" data-dl="https://themewagon.com/themes/sarab/">Sarab</option>
						<option value="https://themewagon.github.io/Fitness/" data-dl="https://themewagon.com/themes/fitness-template/">Fitness</option>
						<option value="https://themewagon.github.io/TiyaGolfClub" data-dl="https://themewagon.com/themes/tiya/">Tiya</option>
					</optgroup>
					<optgroup label="Blog">
						<option value="https://themewagon.github.io/ZenBlog/" data-dl="https://themewagon.com/themes/zenblog/">ZenBlog</option>
						<option value="https://themewagon.github.io/Chefer/" data-dl="https://themewagon.com/themes/chefer/">Chefer</option>
					</optgroup>
					<optgroup label="Real Estate">
						<option value="https://themewagon.github.io/Hilux" data-dl="https://themewagon.com/themes/hilux/">Hilux</option>
					</optgroup>
				</select>
				<a id="downloadLink" href="https://themewagon.com/theme-framework/bootstrap-5/" target="_blank" class="btn btn-sm btn-outline-light">Download</a>
				<a id="newTabLink" href="#" target="_blank" class="btn btn-sm btn-outline-secondary d-none">Open in tab</a>
			</div>
		</div>
	</nav>

	<div id="placeholder" class="d-flex align-items-center justify-content-center flex-column text-muted flex-grow-1">
		<h4>Select a template above to preview it here.</h4>
		<p>300+ free Bootstrap 5 templates from <a href="https://themewagon.com/theme-framework/bootstrap-5/" target="_blank">ThemeWagon</a>.</p>
	</div>

	<iframe id="previewFrame" src="" class="d-none" title="Template Preview"></iframe>

	<div id="app-version" class="visually-hidden"></div>

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.js"></script>
	<script src="ThemeWagon.js"></script>

</body>
</html>
