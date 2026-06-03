<cfscript>
include '/Inc/header.cfm'
</cfscript>

<cfoutput>
<div class="card">
	<div class="card-header bg-primary-subtle">
		This page uses .#request.container#
	</div>
	<div class="card-body">
		<h1 id="ci-badge"></h1>
	</div>
	<div class="card-footer bg-warning-subtle">
		Resize the window to see qualifying .container classes.
	</div>
</div>

<script>
var BREAKPOINTS = [
  { min: 0,    max: 575,        cls: 'container' },
  { min: 576,  max: 767,        cls: 'container-sm' },
  { min: 768,  max: 991,        cls: 'container-md' },
  { min: 992,  max: 1199,       cls: 'container-lg' },
  { min: 1200, max: 1399,       cls: 'container-xl' },
  { min: 1400, max: Infinity,   cls: 'container-xxl' }
]

function updateBadge() {
  var w = window.innerWidth
  var cls = BREAKPOINTS[0].cls
  for (var i = 0; i < BREAKPOINTS.length; i++) {
    if (w >= BREAKPOINTS[i].min && w <= BREAKPOINTS[i].max) {
      cls = BREAKPOINTS[i].cls
      break
    }
  }
  document.getElementById('ci-badge').textContent = w + 'px = .' + cls
}

updateBadge()
window.addEventListener('resize', updateBadge)
</script>
<a href="JavaScript:" class="nav-link">Bootstrap containers</a>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>