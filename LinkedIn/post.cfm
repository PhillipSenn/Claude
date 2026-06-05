<cfscript>
include '/Inc/header.cfm'
</cfscript>

<cfoutput>
<div class="card">
	<div class="card-header bg-primary-subtle"> 
		What do you want to talk about? 
	</div>
	<div class="card-body">
		<textarea id="topic-input" autofocus></textarea>
	</div>
</div>
<div class="card">
	<div class="card-header bg-warning-subtle"> 
		What tone should it have? 
	</div>
	<div class="card-body">
		<div class="btn-group flex-wrap" role="group" id="tone-options">
			<button type="button" class="btn btn-outline-secondary tone-btn active" data-tone="Authentic and personal">Authentic &amp; Personal</button>
			<button type="button" class="btn btn-outline-secondary tone-btn" data-tone="Professional and insightful">Professional</button>
			<button type="button" class="btn btn-outline-secondary tone-btn" data-tone="Bold and opinionated">Bold &amp; Opinionated</button>
			<button type="button" class="btn btn-outline-secondary tone-btn" data-tone="Conversational and friendly">Conversational</button>
			<button type="button" class="btn btn-outline-secondary tone-btn" data-tone="Inspirational and motivating">Inspirational</button>
		</div>
	</div>
</div>
<div class="card">
	<div class="card-header bg-info-subtle"> Add a photo? </div>
	<div class="card-body">
		<div class="image-drop" id="image-drop">
			<input type="file" id="image-input" accept="image/*">
			<div class="drop-icon">📷</div>
			<div class="drop-text"><strong>Click to choose</strong> or drag &amp; drop an image</div>
		</div>
		<div class="image-preview" id="image-preview"> 
			<img id="preview-img" src="" alt="Preview">
			<button class="btn-close" id="remove-img-btn" aria-label="Remove image"></button>
		</div>
	</div>
</div>
<div id="status-bar">Writing your post…</div>
<button class="btn-main" id="generate-btn"> ✦ Generate My Post </button>
<hr class="divider">
<div id="output-section">
	<div class="card">
		<div class="card-header">
			Here's your Post! Edit if you like...
		</div>
		<div class="card-body">
			<div class="generated-post" id="generated-post" contenteditable="true" style="white-space: pre-wrap;"></div>
		</div>
		<div class="card-footer d-flex justify-content-between align-items-center">
			<div class="char-count"><span id="char-count">0</span> / 3000 characters</div>
			<button id="save">Send it!</button>
		</div>
	</div>
</div>
<cfinclude template="/footer.cfm">
<a href="#request.script_name#" class="nav-link active">Post to LinkedIn</a>
<span class="ps-0 nav-link" id="app-version"></span>
<script src="/Inc/js/autosize.js"></script>
<script src="/Inc/js/post_json.js"></script>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>