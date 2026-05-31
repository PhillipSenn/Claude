<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JS1K 2019 Entry #4122.23 — PAC-MAN by feiss</title>
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
	<span class="navbar-brand mb-0 h1">JS1K 2019 Entry #4122.23 &mdash; PAC-MAN <small class="text-muted fs-6">by feiss &middot; 2019 &middot; 1024 bytes</small></span>
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
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-commented-btn" data-bs-toggle="tab" data-bs-target="#tab-commented" type="button" role="tab">Commented</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="tab-html-btn" data-bs-toggle="tab" data-bs-target="#tab-html" type="button" role="tab">HTML</button>
				</li>
			</ul>

			<div class="tab-content" style="height: calc(100% - 46px);">

				<!-- ABOUT TAB -->
				<div class="tab-pane fade show active" id="tab-about" role="tabpanel" style="height:100%; overflow:hidden;">
					<div class="about-scroll">

						<div class="card mb-3">
							<div class="card-header">
								<strong>PAC-MAN</strong> &mdash; JS1K 2019 Entry #4122.23 &mdash; 1024 bytes
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

F = (x,y,w,h,p)=&gt;{ c.fillStyle='#'+p; c.fc(x,y,w,h,p) }

N = r=&gt;{
  F(0,0,l,l,'009')
  for(i in M) for(j in M[i]){
    +M[i][j] &amp;&amp; F(8+j*16, 8+i*16, 30, 30, 111)
    if (r) {
      C[i][j] = +M[i][j]
      g=h=&gt;({x:h,y:h,z:h,w:h,Z:h,W:h,d:(t++%4)+1,s:9})
      G=[g(25),g(5),g(0),g(17),g(16)]
      k=4
    }
  }
}

N(1)
c.lineWidth= 12

onkeydown=e=&gt;k=41-e.which

setInterval(()=&gt;{
  N()
  S = 298
  for(i in M) for(j in M[i]){
    C[i][j] &amp;&amp; F(22+j*16, 22+i*16, 3, 3, 'eee', S--)
  }
  c.fx(S,220,220)
  for(i in G) with(G[i]){
    if (s&gt;9){
      x = z
      y = w
      z -= d%2?0:d-3
      w -= d%2?d-2:0
      s = 0
    }
    if (i == 4 &amp;&amp; d != k){
      Z = x - (k%2?0:k-3)
      W = y - (k%2?k-2:0)
      if(+M[W][Z]){
        d = k
        z = Z
        w = W
        s = 0
      }
    }
    if(w&lt;0 || !+M[w][z]){
      z = x
      w = y
      d = i==4?k:(d+t)%4+1
      s = 7
    }
    if(i&lt;4) {
      if (z==G[4].x &amp;&amp; w==G[4].y) N(1)
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
      if(m&lt;0) m=-m
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
					<pre id="src-expanded" class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0;">
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

        if (entity.step &gt; 9) {
            entity.col     = entity.nextCol
            entity.row     = entity.nextRow
            entity.nextCol -= (entity.direction % 2) ? 0 : entity.direction - 3
            entity.nextRow -= (entity.direction % 2) ? entity.direction - 2 : 0
            entity.step    = 0
        }

        if (i == 4 &amp;&amp; entity.direction !== playerDirection) {
            entity.turnCol = entity.col - ((playerDirection % 2) ? 0 : playerDirection - 3)
            entity.turnRow = entity.row - ((playerDirection % 2) ? playerDirection - 2 : 0)
            if (+mazeRows[entity.turnRow][entity.turnCol]) {
                entity.direction = playerDirection
                entity.nextCol   = entity.turnCol
                entity.nextRow   = entity.turnRow
                entity.step      = 0
            }
        }

        if (entity.nextRow &lt; 0 || entity.nextRow &gt;= mazeRows.length || !+mazeRows[entity.nextRow][entity.nextCol]) {
            entity.nextCol   = entity.col
            entity.nextRow   = entity.row
            entity.direction = (i == 4) ? playerDirection : (entity.direction + frameCounter) % 4 + 1
            entity.step      = 7
        }

        if (i &lt; 4) {
            if (entity.nextCol === entities[4].col &amp;&amp; entity.nextRow === entities[4].row) {
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
            if (mouthAngle &lt; 0) {
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

setInterval(gameTick, 22)
</pre>
					</div>
				</div>

				<!-- COMMENTED TAB -->
				<div class="tab-pane fade" id="tab-commented" role="tabpanel" style="height:100%; overflow:hidden;">
					<div style="display:flex; flex-direction:column; height:100%;">
						<div class="p-2 border-bottom d-flex gap-2">
							<button id="runBtnCommented" class="btn btn-outline-primary btn-sm" onclick="toggleRun('src-commented')">&#9654; Run</button>
							<button class="btn btn-outline-secondary btn-sm" onclick="resetGame()">&#8635; Reset</button>
						</div>
						<div id="src-commented" class="p-3 bg-dark text-light" style="flex:1; overflow:auto; min-height:0; font-family:monospace; font-size:20px; white-space:pre-wrap;">
<div class="text-muted">// JS1K 2019 #4122 - PAC-MAN by feiss</div>
<div class="text-muted">// Commented version: every line explained</div>

<div class="text-muted">/*
 * Iterate over every property of the canvas context object c.
 * Build a 2-character shorthand alias from the 1st and 7th character of the name.
 * e.g. "fillRect"[0]+"fillRect"[6] = "f"+"c" = "fc", so c.fc = c.fillRect
 * e.g. "translate"[0]+"translate"[6] = "t"+"a" = "ta", so c.ta = c.translate
 * e.g. "beginPath"[0]+"beginPath"[6] = "b"+"a" = "ba", so c.ba = c.beginPath
 * e.g. "fillText"[0]+"fillText"[6] = "f"+"x" = "fx", so c.fx = c.fillText
 */
</div>
var methodName
for (methodName in c) {
    c[methodName[0] + methodName[6]] = c[methodName]
}

<div class="text-muted">/*
 * Each number encodes one row of the LEFT half of the 26-column maze as 13 binary bits.
 * 1 = wall tile (drawn as a blue block, and also the cell type entities move along)
 * 0 = open visual corridor (the gap between wall blocks; entities cannot enter)
 * Only 13 columns stored; the right 13 are built by mirroring at runtime.
 */
</div>
var mazeRows = [
    8190, 4226, 4226, 4226, 8191, 4240, 4240,<span class="text-muted">// rows 0-6</span>
    8094,  130,  130,  159,  144,  144, 8176,<span class="text-muted">// rows 7-13</span>
     144,  144,  159,  144,  144, 8190, 4226,<span class="text-muted">// rows 14-20</span>
    4226, 7423, 1168, 1168, 8094, 4098, 4098,<span class="text-muted">// rows 21-27</span>
    8191<span class="text-muted">// row 28</span>
]

<div class="text-muted">// foodGrid[row][col] holds whether a food pellet exists at that cell (1=yes, 0=eaten)</div>
var foodGrid = []

<div class="text-muted">// frameCounter is incremented each time Pac-Man is drawn; drives mouth open/close animation</div>
var frameCounter = 0

<div class="text-muted">// facingAngle rotates Pac-Man's arc so the mouth gap faces his direction of travel</div>
var facingAngle = 0

<div class="text-muted">// entities[0..3] are the four ghosts; entities[4] is Pac-Man</div>
var entities

<div class="text-muted">// playerDirection is set by arrow keys: 1=down 2=right 3=up 4=left</div>
var playerDirection

<div class="text-muted">// Convert each integer in mazeRows into a full 26-element array of '0'/'1' characters.</div>
<div class="text-muted">// Wrapped in an IIFE so row/col/halfRow don't pollute the global scope.</div>
;(function buildMaze() {
    var row, col, halfRow
    for (row in mazeRows) {
<div class="text-muted">// Convert the integer to a 13-character binary string (the left half)</div>
        halfRow = mazeRows[row].toString(2).padStart(13, 0)
<div class="text-muted">// Mirror: iterate col 0..12, each time appending the symmetric character.</div>
<div class="text-muted">// halfRow.length - col*2 - 1 walks inward from the right end.</div>
        for (col in halfRow) {
            halfRow += halfRow[halfRow.length - col * 2 - 1]
        }
<div class="text-muted">// Replace the integer with the 26-element character array</div>
        mazeRows[row] = halfRow.split('')
<div class="text-muted">// Initialise the food grid row as an empty array (filled in drawScene)</div>
        foodGrid[row] = []
    }
}())

<div class="text-muted">// Draw a filled rectangle using the aliased fillRect (c.fc).</div>
<div class="text-muted">// color is a 3-char hex shorthand: '009'=#000099 (blue bg), '111'=#111111 (wall)</div>
function fillBlock(x, y, w, h, color) {
    c.fillStyle = '#' + color<span class="text-muted">// set the fill colour</span>
    c.fc(x, y, w, h)<span class="text-muted">// c.fc = c.fillRect, draw the rectangle</span>
}

<div class="text-muted">// drawScene() redraws the maze background every frame.</div>
<div class="text-muted">// drawScene(true) also resets food and respawns all entities (game start / game over).</div>
function drawScene(resetGame) {
    var row, col
    fillBlock(0, 0, 500, 500, '009')<span class="text-muted">// fill entire canvas dark blue (clear frame)</span>
    for (row in mazeRows) {
        for (col in mazeRows[row]) {
<div class="text-muted">// +mazeRows[row][col] coerces '1'-&gt;1 (truthy) and '0'-&gt;0 (falsy)</div>
            if (+mazeRows[row][col]) {
<div class="text-muted">// Draw a dark wall tile 30x30px; grid spacing is 16px with 8px margin</div>
                fillBlock(8 + col * 16, 8 + row * 16, 30, 30, '111')
            }
            if (resetGame) {
<div class="text-muted">// Seed food: 1 on wall cells (which is where entities travel and eat)</div>
                foodGrid[row][col] = +mazeRows[row][col]
            }
        }
    }
    if (resetGame) {
        entities = [
            makeEntity(25),<span class="text-muted">// ghost 1 - red</span>
            makeEntity(5),<span class="text-muted">// ghost 2 - orange</span>
            makeEntity(0),<span class="text-muted">// ghost 3 - dark red</span>
            makeEntity(17),<span class="text-muted">// ghost 4 - cyan</span>
            makeEntity(16)<span class="text-muted">// Pac-Man</span>
        ]
        playerDirection = 4<span class="text-muted">// start moving up (direction 4 = up)</span>
    }
}

<div class="text-muted">/*
 * Build one entity object. startPos sets col AND row to the same value
 * (a deliberate shortcut: entities start on wall cells and bounce to open positions).
 * direction cycles 1-4 using frameCounter so each entity starts facing differently.
 * step=9 means the very next tick (step+=1 -&gt; 10 &gt; 9) triggers the first tile advance.
 */
</div>
function makeEntity(startPos) {
    return {
        col:       startPos,<span class="text-muted">// current grid column (integer)</span>
        row:       startPos,<span class="text-muted">// current grid row (integer)</span>
        nextCol:   startPos,<span class="text-muted">// target column being moved toward</span>
        nextRow:   startPos,<span class="text-muted">// target row being moved toward</span>
        turnCol:   startPos,<span class="text-muted">// lookahead column when testing a direction change</span>
        turnRow:   startPos,<span class="text-muted">// lookahead row when testing a direction change</span>
        direction: (frameCounter++ % 4) + 1,<span class="text-muted">// starting direction 1-4</span>
        step:      9<span class="text-muted">// sub-step counter; drives smooth interpolation</span>
    }
}

drawScene(true)<span class="text-muted">// first draw: build maze and spawn all entities</span>
c.lineWidth = 12<span class="text-muted">// stroke width for Pac-Man's arc (his body outline)</span>

<div class="text-muted">/*
 * Map arrow key codes to direction values 1-4.
 * Key codes: Left=37, Up=38, Right=39, Down=40
 * 41 - 37 = 4 (left), 41 - 38 = 3 (up), 41 - 39 = 2 (right), 41 - 40 = 1 (down)
 */
</div>
onkeydown = function handleKey(event) {
    playerDirection = 41 - event.which
}

<div class="text-muted">// Main game loop, called every 22ms (approx 45fps).</div>
function gameTick() {
    var row, col, i, entity, ghostColor, pixelX, pixelY, mouthAngle

    drawScene()<span class="text-muted">// repaint the maze walls (clears previous frame)</span>

<div class="text-muted">// Draw food pellets and count how many remain.</div>
<div class="text-muted">// foodRemaining starts at 298 and decrements for each pellet drawn.</div>
    var foodRemaining = 298
    for (row in mazeRows) {
        for (col in mazeRows[row]) {
            if (foodGrid[row][col]) {
<div class="text-muted">// Draw a 3x3 white dot centred in the cell</div>
                fillBlock(22 + col * 16, 22 + row * 16, 3, 3, 'eee')
                foodRemaining -= 1
            }
        }
    }
<div class="text-muted">// c.fx = c.fillText; display score as remaining pellet count</div>
    c.fx(foodRemaining, 220, 220)

    for (i in entities) {
        entity = entities[i]

<div class="text-muted">/*
 * TILE ADVANCE: once step exceeds 9, the entity has crossed a full tile.
 * Commit the move: current position becomes the target position.
 * Then compute the NEXT target tile in the current direction.
 * 
 * Direction encoding:
 * Odd directions  (1=down, 3=up)   change the row
 * Even directions (2=right, 4=left) change the column
 * 
 * nextCol formula: nextCol -= (direction%2) ? 0 : direction-3
 * direction=2: nextCol -= (2-3) = nextCol += 1  (move right)
 * direction=4: nextCol -= (4-3) = nextCol -= 1  (move left)
 * direction=1 or 3: subtract 0   (column unchanged)
 * 
 * nextRow formula: nextRow -= (direction%2) ? direction-2 : 0
 * direction=1: nextRow -= (1-2) = nextRow += 1  (move down)
 * direction=3: nextRow -= (3-2) = nextRow -= 1  (move up)
 * direction=2 or 4: subtract 0   (row unchanged)
 */
</div>
        if (entity.step &gt; 9) {
            entity.col     = entity.nextCol<span class="text-muted">// commit column</span>
            entity.row     = entity.nextRow<span class="text-muted">// commit row</span>
            entity.nextCol -= (entity.direction % 2) ? 0 : entity.direction - 3
            entity.nextRow -= (entity.direction % 2) ? entity.direction - 2 : 0
            entity.step    = 0<span class="text-muted">// reset sub-step counter</span>
        }

<div class="text-muted">/*
 * DIRECTION CHANGE (Pac-Man only, index 4):
 * When the player presses a new direction, look one step ahead in that direction.
 * If the lookahead cell is a wall cell (value '1', truthy), the turn is valid.
 * Pac-Man can only move along wall cells; '0' cells are impassable gaps.
 */
</div>
        if (i == 4 &amp;&amp; entity.direction !== playerDirection) {
<div class="text-muted">// Compute the lookahead tile using the same direction-to-delta formula</div>
            entity.turnCol = entity.col - ((playerDirection % 2) ? 0 : playerDirection - 3)
            entity.turnRow = entity.row - ((playerDirection % 2) ? playerDirection - 2 : 0)
<div class="text-muted">// +mazeRows[turnRow][turnCol] is truthy (1) for wall cells = valid to enter</div>
            if (+mazeRows[entity.turnRow][entity.turnCol]) {
                entity.direction = playerDirection<span class="text-muted">// commit the new direction</span>
                entity.nextCol   = entity.turnCol<span class="text-muted">// move toward the lookahead tile</span>
                entity.nextRow   = entity.turnRow
                entity.step      = 0<span class="text-muted">// restart sub-step from zero</span>
            }
        }

<div class="text-muted">/*
 * WALL COLLISION: if the next tile is out of bounds or is a '0' (gap) cell, bounce.
 * entity.nextRow &lt; 0 catches the top boundary
 * entity.nextRow &gt;= mazeRows.length catches the bottom boundary
 * !+mazeRows[nextRow][nextCol] fires when the cell value is '0' (open gap)
 */
</div>
        if (entity.nextRow &lt; 0 || entity.nextRow &gt;= mazeRows.length || !+mazeRows[entity.nextRow][entity.nextCol]) {
            entity.nextCol = entity.col<span class="text-muted">// snap target back to current position</span>
            entity.nextRow = entity.row
            if (i == 4) {
<div class="text-muted">// Pac-Man: keep trying the player's desired direction</div>
                entity.direction = playerDirection
            } else {
<div class="text-muted">/*
 * Ghost AI: pick a new direction using frame counter for pseudo-randomness.
 * (entity.direction + frameCounter) % 4 + 1 gives a value 1-4 that varies
 * each time a ghost hits a wall, producing different turns per ghost.
 */
</div>
                entity.direction = (entity.direction + frameCounter) % 4 + 1
            }
            entity.step = 7<span class="text-muted">// short delay before attempting to move again</span>
        }

<div class="text-muted">// DRAW GHOST (entities 0-3):</div>
        if (i &lt; 4) {
<div class="text-muted">// Collision detection: if ghost target tile matches Pac-Man's current tile, reset</div>
            if (entity.nextCol === entities[4].col &amp;&amp; entity.nextRow === entities[4].row) {
                drawScene(true)<span class="text-muted">// ghost caught Pac-Man: full game reset</span>
            }

<div class="text-muted">/*
 * Smooth interpolated pixel position:
 * rendered = currentTile + (targetTile - currentTile) * step/10
 * At step=0: renders at currentTile. At step=9: nearly at targetTile.
 */
</div>
            pixelX = 12 + (entity.col + (entity.nextCol - entity.col) * entity.step / 10) * 16
            pixelY = 10 + (entity.row + (entity.nextRow - entity.row) * entity.step / 10) * 16

            c.ta(pixelX, pixelY)<span class="text-muted">// c.ta = c.translate; shift canvas origin to ghost</span>

            ghostColor = ['f77', 'c70', 'd22', '09c'][i]<span class="text-muted">// one colour per ghost</span>

<div class="text-muted">// Ghost sprite built from 6 fillRect calls (all coords relative to translate):</div>
            fillBlock( 1,  5, 22, 21, ghostColor)<span class="text-muted">// main body block</span>
            fillBlock( 4,  2, 16,  8, ghostColor)<span class="text-muted">// head dome (rounded top)</span>
            fillBlock( 6, 23, 13,  3, '111')<span class="text-muted">// gap between the two legs</span>
            fillBlock( 4,  8, 16,  7, 'FFF')<span class="text-muted">// white eye area</span>
            fillBlock( 7,  8, 11,  4, '111')<span class="text-muted">// dark pupils inside eye whites</span>
            fillBlock(10,  0,  4, 26, ghostColor)<span class="text-muted">// vertical stripe: top + leg divider</span>

            c.ta(-pixelX, -pixelY)<span class="text-muted">// undo the translate; restore canvas origin</span>
        }

<div class="text-muted">// DRAW PAC-MAN (entity index 4):</div>
        if (i == 4) {
<div class="text-muted">// Remove food pellet at Pac-Man's current integer tile position</div>
            foodGrid[entity.row][entity.col] = 0

<div class="text-muted">/*
 * Compute rotation so the mouth gap faces direction of travel.
 * Maps direction 1-4 to multiples of ~pi/2 (using 3.1 as approximation of pi):
 * direction=1: 1/2 = 0.5   direction=2: 2%3 = 2   (wrong; should be 0)
 * direction=3: 3/2 = 1.5   direction=4: 4%3 = 1
 * The formula is a byte-saving trick; imprecise but visually acceptable.
 */
</div>
            facingAngle = (entity.direction % 2) ? entity.direction / 2 : entity.direction % 3

<div class="text-muted">/*
 * Triangle-wave mouth animation without Math.sin:
 * (frameCounter/6)%2 oscillates 0-&gt;1-&gt;0 slowly (period=12 frames)
 * Subtract 1.1 -&gt; range -1.1 to +0.9; take abs -&gt; range 0.1 to 1.1
 * Result: mouthAngle smoothly opens and closes each ~12 frames
 */
</div>
            mouthAngle = (frameCounter++ / 6) % 2 - 1.1
            if (mouthAngle &lt; 0) {
                mouthAngle = -mouthAngle<span class="text-muted">// manual Math.abs() to save bytes</span>
            }

<div class="text-muted">// Interpolated pixel position (same formula as ghosts)</div>
            pixelX = 22 + (entity.col + (entity.nextCol - entity.col) * entity.step / 10) * 16
            pixelY = 22 + (entity.row + (entity.nextRow - entity.row) * entity.step / 10) * 16

            c.strokeStyle = '#ff0'<span class="text-muted">// bright yellow stroke colour</span>
            c.ba()<span class="text-muted">// c.ba = c.beginPath; start a new path</span>
<div class="text-muted">/*
 * Draw an arc with a wedge-shaped gap (the mouth):
 * startAngle = 3.1 * facingAngle + mouthAngle  (one jaw)
 * endAngle   = 3.1 * facingAngle - mouthAngle  (other jaw)
 * The gap width is 2 * mouthAngle radians, centred on facingAngle * pi
 */
</div>
            c.arc(pixelX, pixelY, 5, 3.1 * facingAngle + mouthAngle, 3.1 * facingAngle - mouthAngle)
            c.stroke()<span class="text-muted">// render the arc outline</span>
        }

        entity.step += 1<span class="text-muted">// advance sub-step; at step=10 the next tile advance triggers</span>
    }
}

setInterval(gameTick, 22)<span class="text-muted">// start the game loop: 22ms interval = approx 45fps</span>
</div>
					</div>
				</div>

				<!-- HTML TAB -->
				<div class="tab-pane fade" id="tab-html" role="tabpanel" style="height:100%; overflow:hidden;">
					<div style="display:flex; flex-direction:column; height:100%;">
						<div class="p-2 border-bottom text-muted" style="font-size:13px;">
							The full HTML document injected into the iframe — including the JS1K shim and the game source.
						</div>
						<pre id="html-viewer" class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0; font-size:20px;"></pre>
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
	if (activeSourceId === 'src-commented') {
		return document.getElementById('runBtnCommented')
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
	if (isRunning && activeSourceId === sourceId) {
		resetGame()
		return
	}
	activeSourceId = sourceId
	var code = document.getElementById(sourceId).textContent
	loadIntoFrame(code, false)
	setRunning(true)
}

function resetGame() {
	isRunning = false
	var b1 = document.getElementById('runBtn')
	var b2 = document.getElementById('runBtnExpanded')
	var b3 = document.getElementById('runBtnCommented')
	b1.textContent = '\u25B6 Run'
	b1.classList.remove('btn-outline-warning')
	b1.classList.add('btn-outline-primary')
	b2.textContent = '\u25B6 Run'
	b2.classList.remove('btn-outline-warning')
	b2.classList.add('btn-outline-primary')
	if (b3) {
		b3.textContent = '\u25B6 Run'
		b3.classList.remove('btn-outline-warning')
		b3.classList.add('btn-outline-primary')
	}

	// Use whichever tab is currently visible
	var expandedActive = document.getElementById('tab-expanded').classList.contains('active')
	var sourceId = expandedActive ? 'src-expanded' : 'src-original'
	activeSourceId = sourceId
	var code = document.getElementById(sourceId).textContent
	loadIntoFrame(code, true)
}

// Switching to About tab resets; other tab switches leave iframe alone
function showHtmlSource() {
	var shimOnly = [
		'<!DOCTYPE html>',
		'<html>',
		'<head>',
		'<meta charset="UTF-8">',
		'<style>body { margin: 0; overflow: hidden; background: #000 }</style>',
		'</head>',
		'<body>',
		'<canvas id="c" width="500" height="500"></canvas>',
		'<script>',
		'var a = document.getElementById("c")',
		'var c = a.getContext("2d")',
		'var b = document.body',
		'var d = document',
		'<' + '/script>',
		'<!-- game source injected here - see other tabs -->',
		'</body>',
		'</html>'
	]
	document.getElementById('html-viewer').textContent = shimOnly.join('\n')
}

function buildHtmlDoc(code) {
	var interceptor = ''
	var parts = [
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
	]
	return parts.join('\n')
}

document.getElementById('codeTabs').addEventListener('shown.bs.tab', function onTabShown(e) {
	var target = e.target.getAttribute('data-bs-target')
	if (target === '#tab-about') {
		resetGame()
	}
	if (target === '#tab-original' || target === '#tab-expanded' || target === '#tab-commented') {
		if (isRunning) { resetGame() }
	}
	if (target === '#tab-html') {
		showHtmlSource()
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
