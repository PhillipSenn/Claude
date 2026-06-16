<cfinclude template="/Inc/header.cfm">

<style>
#viewport { position:relative; height:78vh; overflow:hidden; background:#15131a; perspective:600px; }
#world { position:absolute; left:50%; top:50%; width:0; height:0; transform-style:preserve-3d; }
.section, .tile, .painting { position:absolute; transform-style:preserve-3d; }
.tile { left:50%; top:50%; }
.floor { width:600px; height:700px; margin-left:-300px; margin-top:-350px; background:repeating-linear-gradient(90deg, #7a5b35 0px 70px, #6d502d 70px 140px); }
.ceiling { width:600px; height:700px; margin-left:-300px; margin-top:-350px; background:#241f29; }
.wall { width:700px; height:360px; margin-left:-350px; margin-top:-180px; background:linear-gradient(#4a4452 0 78%, #38323f 78% 82%, #2a2530 82%); }
.endwall { width:600px; height:360px; margin-left:-300px; margin-top:-180px; background:#4a4452; }
.painting { left:50%; top:50%; width:340px; margin-left:-170px; margin-top:-150px; text-align:center; backface-visibility:hidden; cursor:pointer; }
.painting img { max-width:300px; max-height:230px; border:12px solid #6e5524; outline:2px solid #3f3012; background:#1c1c1c; box-shadow:0 10px 24px rgba(0,0,0,.55); }
.plaque { display:inline-block; margin-top:8px; padding:2px 10px; background:#c9a86a; color:#2c2313; font-size:12px; border-radius:2px; max-width:300px; }
#vignette { position:absolute; top:0; right:0; bottom:0; left:0; pointer-events:none; background:radial-gradient(ellipse at center, transparent 55%, rgba(0,0,0,.55)); }
#hud { position:absolute; left:0; right:0; bottom:10px; text-align:center; z-index:10; }
#painting-detail { position:fixed; right:16px; top:80px; width:380px; max-height:75vh; overflow:auto; z-index:1040; box-shadow:0 12px 30px rgba(0,0,0,.4); }
</style>

<div class="sticky-top">
	<div class="progress" style="height:1.25rem;border-radius:0;">
		<div class="progress-bar" id="painting-progress" role="progressbar" style="width:0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
	</div>
</div>

<div id="viewport">
	<div id="world"></div>
	<div id="vignette"></div>
	<div id="hud">
		<span id="painting-counter" class="badge bg-dark"></span>
		<span class="badge bg-dark">Arrow keys to walk &middot; PgUp/PgDn to sprint &middot; click a painting for details</span>
	</div>
</div>

<div class="text-center py-2">
	<button type="button" class="btn btn-secondary btn-walk" data-walk="left">&#8634; Turn Left</button>
	<button type="button" class="btn btn-secondary btn-walk" data-walk="forward">&#9650; Forward</button>
	<button type="button" class="btn btn-secondary btn-walk" data-walk="back">&#9660; Back</button>
	<button type="button" class="btn btn-secondary btn-walk" data-walk="right">&#8635; Turn Right</button>
</div>

<div id="painting-detail" class="card" style="display:none;">
	<div class="card-header d-flex justify-content-between align-items-center">
		<h2 class="h5 mb-0" id="detail-title"></h2>
		<button type="button" class="btn-close btn-close-detail" aria-label="Close"></button>
	</div>
	<div class="card-body">
		<img id="detail-image" class="img-fluid mb-2" src="" alt="">
		<div id="detail-description" class="mb-3"></div>
		<dl class="row mb-3" id="detail-attributes"></dl>
		<a id="detail-link" href="" target="_blank">View on rijksmuseum.nl</a>
	</div>
</div>

<a class="nav-link active">Rijksmuseum Walk-Thru</a>
<a class="nav-item" id="app-version"></a>
<cfinclude template="/Inc/footer.cfm">
