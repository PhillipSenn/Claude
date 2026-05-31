<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JS1K 2019 Entry #4122.17 — PAC-MAN by feiss</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css">
<style>
body {
	font-size: 20px;
}
.full-height {
	height: calc(100vh - 56px);
	overflow: hidden;
}
.col-preview {
	padding: 0;
	background: #000;
}
.col-preview iframe {
	width: 100%;
	height: 100%;
	border: none;
	display: block;
}
.code-col {
	display: flex;
	flex-direction: column;
	padding: 0;
	height: 100%;
	overflow: hidden;
}
.tab-content {
	flex: 1;
	overflow: hidden;
}
.tab-pane {
	height: 100%;
}
.about-scroll {
	height: 100%;
	overflow-y: auto;
	padding: 20px;
}
pre.source-pre {
	font-size: 20px;
	line-height: 1.6;
	margin: 0;
	border-radius: 0;
}
</style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark px-3" style="height:56px;">
	<span class="navbar-brand mb-0 h1">JS1K 2019 Entry #4122.17 &mdash; PAC-MAN <small class="text-muted fs-6">by feiss &middot; 2019 &middot; 1024 bytes</small></span>
</nav>

<div class="container-fluid p-0 full-height">
	<div class="row g-0 h-100">

		<!-- LEFT: iframe preview -->
		<div class="col-5 col-preview">
			<iframe id="previewFrame" src="about:blank" title="PAC-MAN preview"></iframe>
		</div>

		<!-- RIGHT: tabs -->
		<div class="col-7 code-col">

			<ul class="nav nav-tabs px-2 pt-1 bg-light" id="codeTabs" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="tab-about-btn" data-bs-toggle="tab" data-bs-target="#tab-about" type="button" role="tab">About</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-original-btn" data-bs-toggle="tab" data-bs-target="#tab-original" type="button" role="tab">Original</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-expanded-btn" data-bs-toggle="tab" data-bs-target="#tab-expanded" type="button" role="tab">Expanded</button>
				</li>
			</ul>

			<div class="tab-content" style="height: calc(100% - 46px);">

				<!-- ABOUT TAB -->
				<div class="tab-pane fade show active" id="tab-about" role="tabpanel" style="height:100%; overflow:hidden;">
					<div class="about-scroll">

						<div class="card mb-3">
							<div class="card-header">
								<strong>PAC-MAN</strong> &mdash; JS1K 2019 Entry #4122.17 &mdash; 1024 bytes
							</div>
							<div class="card-body">
								<p>A fully playable Pac-Man clone squeezed into exactly 1,024 bytes of JavaScript &mdash; including the original map layout, ghost AI, mouth animation, and food counter. Use arrow keys to play.</p>
								<table class="table table-sm table-bordered">
									<tbody>
										<tr><th>Author</th><td>feiss</td></tr>
										<tr><th>GitHub</th><td><a href="https://github.com/feiss" target="_blank">github.com/feiss</a></td></tr>
										<tr><th>Website</th><td><a href="http://feiss.be" target="_blank">feiss.be</a></td></tr>
										<tr><th>Competition</th><td>canvas</td></tr>
										<tr><th>Year</th><td>2019 (10th anniversary JS1K)</td></tr>
										<tr><th>Bytes</th><td>1024 / 1024</td></tr>
									</tbody>
								</table>
								<p>The author&rsquo;s main goal was preserving the original Pac-Man map layout and gameplay feel. Ghost AI is intentionally minimal &mdash; a pseudo-random turn derived from the current direction plus a global frame counter. The final code was packed with <strong>babel-minify</strong> then <strong>regpack</strong> (a string-pattern compressor) to reach the 1024-byte limit.</p>
							</div>
						</div>

						<div class="card mb-3">
							<div class="card-header"><strong>Key Techniques</strong></div>
							<ul class="list-group list-group-flush">
								<li class="list-group-item">Maze stored as 13-bit binary integers &mdash; only the left half, mirrored at runtime to build the symmetric right side</li>
								<li class="list-group-item">Canvas API aliased via <code>c[methodName[0] + methodName[6]]</code> &mdash; turns <code>fillRect</code> into <code>fc</code>, <code>translate</code> into <code>ta</code>, etc.</li>
								<li class="list-group-item">Ghost AI is one expression: <code>(direction + frameCounter) % 4 + 1</code> &mdash; picks a new direction on each wall collision</li>
								<li class="list-group-item">Smooth sub-pixel movement via 10-step interpolation: <code>pixel = origin + (target &minus; origin) &times; step / 10</code></li>
								<li class="list-group-item">Mouth animation uses a triangle wave: <code>Math.abs((frameCounter / 6) % 2 &minus; 1.1)</code></li>
								<li class="list-group-item">All five entities (4 ghosts + Pac-Man) share one loop &mdash; Pac-Man is simply index 4</li>
								<li class="list-group-item">Keyboard mapped as <code>41 &minus; event.which</code> to convert arrow key codes into direction values 1&ndash;4</li>
							</ul>
						</div>

					</div>
				</div>

				<!-- ORIGINAL TAB -->
				<div class="tab-pane fade" id="tab-original" role="tabpanel" style="height:100%; overflow:hidden;">
					<div style="display:flex; flex-direction:column; height:100%;">
					<div class="p-2 border-bottom d-flex gap-2">
						<button id="runBtn" class="btn btn-outline-primary btn-sm" onclick="toggleRun('src-original')">&#9654; Run</button>
						<button class="btn btn-outline-secondary btn-sm" onclick="resetGame()">&#8635; Reset</button>
					</div>
					<pre id="src-original" class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0; font-size:20px;">M=[g=8190, h=4226, h, h, g+1, l=4240, l,
  l=8094, 130, 130, k=159, j=144, j, 8176,
  j, j, k, j, j, g, h, h, 7423, j=1168,
  j, l, k=4098, k, g+1, f=t=0 ]
C=[]

for(i in c) c[i[0]+i[6]] = c[i]

for(i in M) {
  m = M[i].toString(2).padStart(13,0)
  for(j in m) m+=m[m.length-j*2-1]
  M[i] = m.split('')
  C[i] = []
}

F = (x,y,w,h,p)=>{ c.fillStyle='#'+p; c.fc(x,y,w,h,p) }

N = r=>{
  F(0,0,l,l,'009')
  for(i in M) for(j in M[i]){
    +M[i][j] && F(8+j*16, 8+i*16, 30, 30, 111)
    if (r) {
      C[i][j] = +M[i][j]
      g=h=>({x:h,y:h,z:h,w:h,Z:h,W:h,d:(t++%4)+1,s:9})
      G=[g(25),g(5),g(0),g(17),g(16)]
      k=4
    }
  }
}

N(1)
c.lineWidth= 12

onkeydown=e=>k=41-e.which

setInterval(()=>{
  N()
  S = 298
  for(i in M) for(j in M[i]){
    C[i][j] && F(22+j*16, 22+i*16, 3, 3, 'eee', S--)
  }
  c.fx(S,220,220)
  for(i in G) with(G[i]){
    if (s>9){
      x = z
      y = w
      z -= d%2?0:d-3
      w -= d%2?d-2:0
      s = 0
    }
    if (i == 4 && d != k){
      Z = x - (k%2?0:k-3)
      W = y - (k%2?k-2:0)
      if(+M[W][Z]){
        d = k
        z = Z
        w = W
        s = 0
      }
    }
    if(w<0 || !+M[w][z]){
      z = x
      w = y
      d = i==4?k:(d+t)%4+1
      s = 7
    }
    if(i<4) {
      if (z==G[4].x && w==G[4].y) N(1)
      c.ta(X=12 + (x + (z - x)*s/10) * 16, Y=10 + (y + (w - y)*s/10) * 16)
      h=['f77','c70','d22','09c'][i]
      F(1,5,22,21,h)
      F(4,2,16,8,h)
      F(6,23,13,3,111)
      F(4,8,16,7,'FFF')
      F(7,8,11,4,111)
      F(10,0,4,26,h)
      c.ta(-X,-Y)
    }
    if(i==4) {
      C[y][x] = 0
      f = d%2?d/2:d%3
      m = (t++/6)%2-1.1
      if(m<0) m=-m
      c.strokeStyle='#ff0'
      c.ba()
      c.arc(22 + (x + (z - x)*s/10) * 16, 22 + (y + (w - y)*s/10) * 16, 5, 3.1*f+m, 3.1*f-m)
      c.stroke()
    }
    s++
  }
}, 22)</pre>
					</div>
				</div>

				<!-- EXPANDED TAB -->
				<div class="tab-pane fade" id="tab-expanded" role="tabpanel" style="height:100%; overflow:hidden;">
					<div style="display:flex; flex-direction:column; height:100%;">
					<div class="p-2 border-bottom d-flex gap-2">
						<button id="runBtnExpanded" class="btn btn-outline-primary btn-sm" onclick="toggleRun('src-expanded')">&#9654; Run</button>
						<button class="btn btn-outline-secondary btn-sm" onclick="resetGame()">&#8635; Reset</button>
					</div>
					<pre id="src-expanded" class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0;">// JS1K 2019 #4122 - PAC-MAN by feiss
// Expanded version: meaningful variable names, ES5 syntax
//
// NOTE on maze encoding:
//   '1' cells = wall tiles (drawn as blue blocks) AND the paths entities travel
//   '0' cells = open visual corridors (the gaps between wall blocks)
//   Entities move along '1' cells; !+maze[row][col] blocks entry into '0' cells

var methodName
for (methodName in c) {
    c[methodName[0] + methodName[6]] = c[methodName]
}

var mazeRows = [
    8190, 4226, 4226, 4226, 8191, 4240, 4240,
    8094,  130,  130,  159,  144,  144, 8176,
     144,  144,  159,  144,  144, 8190, 4226,
    4226, 7423, 1168, 1168, 8094, 4098, 4098,
    8191
]

var foodGrid = []
var frameCounter = 0
var facingAngle = 0
var entities
var playerDirection

;(function buildMaze() {
    var row, col, halfRow
    for (row in mazeRows) {
        halfRow = mazeRows[row].toString(2).padStart(13, 0)
        for (col in halfRow) {
            halfRow += halfRow[halfRow.length - col * 2 - 1]
        }
        mazeRows[row] = halfRow.split('')
        foodGrid[row] = []
    }
}())

function fillBlock(x, y, w, h, color) {
    c.fillStyle = '#' + color
    c.fc(x, y, w, h)
}

function makeEntity(startPos) {
    return {
        col:       startPos,
        row:       startPos,
        nextCol:   startPos,
        nextRow:   startPos,
        turnCol:   startPos,
        turnRow:   startPos,
        direction: (frameCounter++ % 4) + 1,
        step:      9
    }
}

function drawScene(resetGame) {
    var row, col
    fillBlock(0, 0, 500, 500, '009')
    for (row in mazeRows) {
        for (col in mazeRows[row]) {
            if (+mazeRows[row][col]) {
                fillBlock(8 + col * 16, 8 + row * 16, 30, 30, '111')
            }
            if (resetGame) {
                foodGrid[row][col] = +mazeRows[row][col]
            }
        }
    }
    if (resetGame) {
        entities = [
            makeEntity(25),
            makeEntity(5),
            makeEntity(0),
            makeEntity(17),
            makeEntity(16)
        ]
        playerDirection = 4
    }
}

drawScene(true)
c.lineWidth = 12

onkeydown = function handleKey(event) {
    playerDirection = 41 - event.which
}

function gameTick() {
    var row, col, i, entity, ghostColor, pixelX, pixelY, mouthAngle

    drawScene()

    var foodRemaining = 298
    for (row in mazeRows) {
        for (col in mazeRows[row]) {
            if (foodGrid[row][col]) {
                fillBlock(22 + col * 16, 22 + row * 16, 3, 3, 'eee')
                foodRemaining -= 1
            }
        }
    }
    c.fx(foodRemaining, 220, 220)

    for (i in entities) {
        entity = entities[i]

        if (entity.step > 9) {
            entity.col     = entity.nextCol
            entity.row     = entity.nextRow
            entity.nextCol -= (entity.direction % 2) ? 0 : entity.direction - 3
            entity.nextRow -= (entity.direction % 2) ? entity.direction - 2 : 0
            entity.step    = 0
        }

        if (i == 4 && entity.direction !== playerDirection) {
            entity.turnCol = entity.col - ((playerDirection % 2) ? 0 : playerDirection - 3)
            entity.turnRow = entity.row - ((playerDirection % 2) ? playerDirection - 2 : 0)
            if (+mazeRows[entity.turnRow][entity.turnCol]) {
                entity.direction = playerDirection
                entity.nextCol   = entity.turnCol
                entity.nextRow   = entity.turnRow
                entity.step      = 0
            }
        }

        if (entity.nextRow < 0 || !+mazeRows[entity.nextRow][entity.nextCol]) {
            entity.nextCol   = entity.col
            entity.nextRow   = entity.row
            entity.direction = (i == 4) ? playerDirection : (entity.direction + frameCounter) % 4 + 1
            entity.step      = 7
        }

        if (i < 4) {
            if (entity.nextCol === entities[4].col && entity.nextRow === entities[4].row) {
                drawScene(true)
            }
            pixelX = 12 + (entity.col + (entity.nextCol - entity.col) * entity.step / 10) * 16
            pixelY = 10 + (entity.row + (entity.nextRow - entity.row) * entity.step / 10) * 16
            c.ta(pixelX, pixelY)
            ghostColor = ['f77', 'c70', 'd22', '09c'][i]
            fillBlock( 1,  5, 22, 21, ghostColor)
            fillBlock( 4,  2, 16,  8, ghostColor)
            fillBlock( 6, 23, 13,  3, '111')
            fillBlock( 4,  8, 16,  7, 'FFF')
            fillBlock( 7,  8, 11,  4, '111')
            fillBlock(10,  0,  4, 26, ghostColor)
            c.ta(-pixelX, -pixelY)
        }

        if (i == 4) {
            foodGrid[entity.row][entity.col] = 0
            facingAngle = (entity.direction % 2) ? entity.direction / 2 : entity.direction % 3
            mouthAngle = (frameCounter++ / 6) % 2 - 1.1
            if (mouthAngle < 0) {
                mouthAngle = -mouthAngle
            }
            pixelX = 22 + (entity.col + (entity.nextCol - entity.col) * entity.step / 10) * 16
            pixelY = 22 + (entity.row + (entity.nextRow - entity.row) * entity.step / 10) * 16
            c.strokeStyle = '#ff0'
            c.ba()
            c.arc(pixelX, pixelY, 5, 3.1 * facingAngle + mouthAngle, 3.1 * facingAngle - mouthAngle)
            c.stroke()
        }

        entity.step += 1
    }
}

setInterval(gameTick, 22)</pre>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.bundle.js"></script>
<script>
var isRunning = false
var activeSourceId = 'src-original'
var currentBlobUrl = null

function revokeBlobUrl() {
	if (currentBlobUrl) {
		URL.revokeObjectURL(currentBlobUrl)
		currentBlobUrl = null
	}
}

function loadIntoFrame(code, pauseAfterFirstFrame) {
	var interceptor = ''
	if (pauseAfterFirstFrame) {
		interceptor = [
			'(function installPause() {',
			'  var real = window.setInterval.bind(window)',
			'  window.setInterval = function pausedSetInterval(fn, ms) {',
			'    var id = real(function runOnce() {',
			'      clearInterval(id)',
			'      fn()',
			'    }, ms)',
			'    return id',
			'  }',
			'}())'
		].join('\n')
	}

	var html = [
		'<!DOCTYPE html><html><head><meta charset="UTF-8">',
		'<style>body{margin:0;overflow:hidden;background:#000}</style>',
		'</head><body>',
		'<canvas id="c" width="500" height="500"></canvas>',
		'<script>',
		'var a = document.getElementById("c")',
		'var c = a.getContext("2d")',
		'var b = document.body',
		'var d = document',
		interceptor,
		'<' + '/script>',
		'<script>',
		code,
		'<' + '/script>',
		'</body></html>'
	].join('\n')

	revokeBlobUrl()
	var blob = new Blob([html], { type: 'text/html' })
	currentBlobUrl = URL.createObjectURL(blob)
	var frame = document.getElementById('previewFrame')
	frame.src = currentBlobUrl
	frame.onload = function onFrameLoad() {
		frame.contentWindow.focus()
	}
}

function getRunBtn() {
	if (activeSourceId === 'src-original') {
		return document.getElementById('runBtn')
	}
	return document.getElementById('runBtnExpanded')
}

function setRunning(running) {
	isRunning = running
	var btn = getRunBtn()
	if (running) {
		btn.textContent = '\u25B6 Running'
		btn.classList.remove('btn-outline-primary')
		btn.classList.add('btn-outline-success')
	} else {
		btn.textContent = '\u25B6 Run'
		btn.classList.remove('btn-outline-success')
		btn.classList.add('btn-outline-primary')
	}
}

function toggleRun(sourceId) {
	activeSourceId = sourceId
	var code = document.getElementById(sourceId).textContent
	loadIntoFrame(code, false)
	setRunning(true)
}

function resetGame() {
	isRunning = false
	var b1 = document.getElementById('runBtn')
	var b2 = document.getElementById('runBtnExpanded')
	b1.textContent = '\u25B6 Run'
	b1.classList.remove('btn-outline-success')
	b1.classList.add('btn-outline-primary')
	b2.textContent = '\u25B6 Run'
	b2.classList.remove('btn-outline-success')
	b2.classList.add('btn-outline-primary')

	// Use whichever tab is currently visible
	var expandedActive = document.getElementById('tab-expanded').classList.contains('active')
	var sourceId = expandedActive ? 'src-expanded' : 'src-original'
	activeSourceId = sourceId
	var code = document.getElementById(sourceId).textContent
	loadIntoFrame(code, true)
}

// Switching to About tab resets; other tab switches leave iframe alone
document.getElementById('codeTabs').addEventListener('shown.bs.tab', function onTabShown(e) {
	var target = e.target.getAttribute('data-bs-target')
	if (target === '#tab-about') {
		resetGame()
	}
})

// Show frozen first frame on load using original source
window.addEventListener('load', function onLoad() {
	activeSourceId = 'src-original'
	var code = document.getElementById('src-original').textContent
	loadIntoFrame(code, true)
})
</script>
</body>
</html>
