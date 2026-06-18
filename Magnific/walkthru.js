// ─── Sprite sheet layout (walkthru.png, black bg) ────────────────────────
// Row 0 (idle):  1 frame  — col 266, row 25,  w 70,  h 167
// Row 1 (walk):  4 frames — rows 211-385
// Row 2 (walk):  4 frames — rows 421-591

var SHEET_URL = 'walkthru.png'

var IDLE_FRAME = { sx: 266, sy: 25,  sw: 70,  sh: 167 }

var WALK_FRAMES = [
  { sx:  52, sy: 211, sw: 70,  sh: 175 },
  { sx: 198, sy: 211, sw: 75,  sh: 175 },
  { sx: 336, sy: 211, sw: 101, sh: 175 },
  { sx: 493, sy: 211, sw: 72,  sh: 175 },
  { sx:  38, sy: 421, sw: 80,  sh: 171 },
  { sx: 188, sy: 421, sw: 81,  sh: 171 },
  { sx: 347, sy: 421, sw: 73,  sh: 171 },
  { sx: 494, sy: 421, sw: 71,  sh: 171 }
]

var DISPLAY_HEIGHT = 160
var FRAME_DURATION = 100
var WALK_SPEED     = 3
var FLOOR_Y        = 360

// ─── State ────────────────────────────────────────────────────────────────
var spriteSheet   = new Image()
var loaded        = false
var x             = 300
var facing        = 1
var walking       = false
var frameIndex    = 0
var lastFrameTime = 0
var keysDown      = {}

var canvas = document.getElementById('gameCanvas')
var ctx    = canvas.getContext('2d')

// ─── Load ─────────────────────────────────────────────────────────────────
spriteSheet.onload = function onSpriteLoaded() {
  loaded = true
  requestAnimationFrame(gameLoop)
}
spriteSheet.src = SHEET_URL

// ─── Input ────────────────────────────────────────────────────────────────
document.addEventListener('keydown', function onKeyDown(e) {
  if (e.key === 'ArrowLeft' || e.key === 'ArrowRight') {
    e.preventDefault()
  }
  keysDown[e.key] = true
})

document.addEventListener('keyup', function onKeyUp(e) {
  keysDown[e.key] = false
})

// ─── Loop ─────────────────────────────────────────────────────────────────
function gameLoop(timestamp) {
  update(timestamp)
  draw()
  requestAnimationFrame(gameLoop)
}

function update(timestamp) {
  walking = false

  if (keysDown['ArrowRight']) {
    x += WALK_SPEED
    facing = 1
    walking = true
  }

  if (keysDown['ArrowLeft']) {
    x -= WALK_SPEED
    facing = -1
    walking = true
  }

  if (x < 0) x = 0
  if (x > canvas.width) x = canvas.width

  if (walking) {
    if (timestamp - lastFrameTime > FRAME_DURATION) {
      frameIndex = (frameIndex + 1) % WALK_FRAMES.length
      lastFrameTime = timestamp
    }
  } else {
    frameIndex = 0
  }
}

function draw() {
  ctx.clearRect(0, 0, canvas.width, canvas.height)

  ctx.fillStyle = '#5a8a3a'
  ctx.fillRect(0, FLOOR_Y, canvas.width, canvas.height - FLOOR_Y)

  if (!loaded) return

  var frame = walking ? WALK_FRAMES[frameIndex] : IDLE_FRAME
  var scale = DISPLAY_HEIGHT / frame.sh
  var dw    = frame.sw * scale
  var dh    = DISPLAY_HEIGHT
  var drawX = x - dw / 2
  var drawY = FLOOR_Y - dh

  ctx.save()

  if (facing === -1) {
    ctx.translate(x, 0)
    ctx.scale(-1, 1)
    ctx.translate(-x, 0)
  }

  ctx.drawImage(
    spriteSheet,
    frame.sx, frame.sy, frame.sw, frame.sh,
    drawX, drawY, dw, dh
  )

  ctx.restore()

  keyOutBlack(drawX, drawY, dw, dh)
}

function keyOutBlack(drawX, drawY, dw, dh) {
  var x0 = Math.floor(drawX)
  var y0 = Math.floor(drawY)
  var w  = Math.ceil(dw) + 2
  var h  = Math.ceil(dh) + 2

  if (x0 < 0) { w += x0; x0 = 0 }
  if (y0 < 0) { h += y0; y0 = 0 }
  if (x0 + w > canvas.width)  w = canvas.width  - x0
  if (y0 + h > canvas.height) h = canvas.height - y0
  if (w <= 0 || h <= 0) return

  var imageData = ctx.getImageData(x0, y0, w, h)
  var data = imageData.data

  for (var i = 0; i < data.length; i += 4) {
    if (data[i] < 40 && data[i + 1] < 40 && data[i + 2] < 40) {
      data[i + 3] = 0
    }
  }

  ctx.putImageData(imageData, x0, y0)
}
$('#app-version').html('&bull; v2')