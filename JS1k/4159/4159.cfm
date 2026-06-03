<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JS1K 2019 Entry #4159 — i feel fine by Alexander Timoshenko</title>
<link rel="stylesheet" href="/Inc/css/bootstrap.css">
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
.text-muted { color: #aaa !important; }
</style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark px-3" style="height:56px;">
  <span class="navbar-brand mb-0 h1">JS1K 2019 Entry #4159 &mdash; i feel fine <small class="text-muted fs-6">by Alexander Timoshenko &middot; 2019 &middot; 980 bytes &middot; v20</small></span>
</nav>

<div class="container-fluid p-0 full-height">
  <div class="row g-0 h-100">

    <!-- LEFT: iframe preview -->
    <div class="col-5 col-preview">
      <iframe id="previewFrame" src="about:blank" title="i feel fine preview"></iframe>
    </div>

    <!-- RIGHT: tabs -->
    <div class="col-7 code-col">

      <ul class="nav nav-tabs px-2 pt-1 bg-light" id="codeTabs" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="tab-about-btn" data-bs-toggle="tab" data-bs-target="#tab-about" type="button" role="tab">About</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="tab-original-btn" data-bs-toggle="tab" data-bs-target="#tab-original" type="button" role="tab">Source</button>
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
                <strong>i feel fine</strong> &mdash; JS1K 2019 Entry #4159 &mdash; 980 bytes
              </div>
              <div class="card-body">
                <p>A real-time raymarched rotating tunnel rendered in WebGL, packed into 980 bytes of JavaScript. The entire scene &mdash; geometry, lighting, fog, and animation &mdash; lives in a single GLSL fragment shader.</p>
                <table class="table table-sm table-bordered">
                  <tbody>
                    <tr><th>Author</th><td>Alexander Timoshenko</td></tr>
                    <tr><th>Competition</th><td>webgl</td></tr>
                    <tr><th>Year</th><td>2019 (10th anniversary JS1K)</td></tr>
                    <tr><th>Bytes</th><td>980 / 1024</td></tr>
                    <tr><th>Technique</th><td>Raymarching / SDF</td></tr>
                  </tbody>
                </table>
                <p>The JavaScript is almost entirely boilerplate: compile two shaders, link a program, upload a full-screen triangle, then drive a <code>uniform float T</code> (time) via <code>setInterval</code>. All the visual work happens on the GPU.</p>
                <p>The demo uses the classic JS1K trick of aliasing WebGL methods by their first and seventh characters &mdash; <code>for(B in g) g[B[0]+B[6]] = g[B]</code> &mdash; so calls like <code>createShader</code> become <code>cS</code>, saving dozens of bytes.</p>
              </div>
            </div>

            <div class="card mb-3">
              <div class="card-header"><strong>Key Techniques</strong></div>
              <ul class="list-group list-group-flush">
                <li class="list-group-item">Full-screen triangle rendered with 3 vertices from a 6-byte <code>Int8Array</code> &mdash; two triangles worth of positions packed as <code>(0,0), (0,6), (6,0)</code> in <code>BYTE</code> format</li>
                <li class="list-group-item">WebGL method aliasing via <code>for(B in g) g[B[0]+B[6]] = g[B]</code> &mdash; e.g. <code>createShader&rarr;cS</code>, <code>shaderSource&rarr;sS</code>, <code>compileShader&rarr;cS</code>, <code>useProgram&rarr;ug</code></li>
                <li class="list-group-item">Raymarching loop: 100 steps along each ray from a fixed eye, using a signed distance function to find scene intersections</li>
                <li class="list-group-item"><code>bo(p)</code> &mdash; a box SDF that defines the tunnel cross-section; the tunnel is an infinite repeating box</li>
                <li class="list-group-item"><code>s(p)</code> &mdash; the full scene SDF: combines <code>fract()</code>-based repetition, <code>smoothstep</code> for the mosaic tile pattern on the walls, and <code>min(t, bo(p))</code> to union the tile and tunnel geometry</li>
                <li class="list-group-item">Surface normal computed by the central-difference tetrahedron trick: four SDF samples with offsets <code>e.yxx, e.xxy, e.xyx, e.yyy</code></li>
                <li class="list-group-item">Camera rotation uses a 2D rotation matrix built from <code>vec2(sin(3+T), cos(3+T))</code> &mdash; the same vector reused as <code>#define rt</code> for both the box orientation and the light direction</li>
                <li class="list-group-item">Ray twist: <code>p.xy</code> is rotated by <code>.05*T</code> each step, so the tunnel appears to corkscrew around the viewer</li>
              </ul>
            </div>

            <div class="card mb-3">
              <div class="card-header"><strong>Shader at a Glance</strong></div>
              <div class="card-body" style="font-size:16px;">
                <p><strong>Vertex shader</strong> &mdash; trivial pass-through. Takes a <code>vec2 p</code> attribute, outputs <code>gl_Position = vec4(p-1, 0, 1)</code> and passes <code>u = p-1</code> (the NDC UV) to the fragment shader.</p>
                <p><strong>Fragment shader</strong> &mdash; does all the work:</p>
                <ol>
                  <li>Build ray direction <code>d = normalize(vec3(u, 1))</code> from the UV.</li>
                  <li>March 100 steps; at each step twist <code>p.xy</code> by the time-varying rotation.</li>
                  <li>When a hit is found (<code>h &lt; e</code>), compute the surface normal and a diffuse term <code>l</code>.</li>
                  <li>Colour is <code>vec3(.5, l, l)</code> minus fog (<code>t*.05</code>); box-hit cells are tinted cyan-blue.</li>
                </ol>
              </div>
            </div>

          </div>
        </div>

        <!-- ORIGINAL TAB -->
        <div class="tab-pane fade" id="tab-original" role="tabpanel" style="height:100%; overflow:hidden;">
          <div style="display:flex; flex-direction:column; height:100%;">
            <div class="px-3 pt-2 pb-1 text-muted border-bottom" style="font-size:14px;">
              This is the js1k entry, which no longer works.
				  <br>I had Claude fix it and expand upon it.
					<p>You can run it in the Expanded tab.</p>
            </div>
            <pre id="src-original" class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0; font-size:20px; white-space:pre-wrap; word-break:break-all;">for(_='for~uni~mZ3.+T)YfloatXp.WWz)Rs(QabQOcoQNbo(M0,L, K0KJ; H);GG in(.5(A){vec2) return )+e..05xy3  + max()K = sScS(3563void ma3(varyg  uHlength(g)O1G}`GceGaS(PKAG * normalize(*Qpe.X ~(B  gg[ B[0]+B[6]]g[B];with(g	PcP(G3`attribute  p;gl_Position=4(u=p-1.,L 2`precision highp XHZ TH\\n#defe rt (sY,NY)\\nMppOp-*rt,1)WxKWyR-.1;}Qpg =fract(WKT+R 0.47- ;gsmoothstep(0.3K1.K25.ggGt.25(5.-2(NWx)sT+R)Wx1.-Wy))GmtKMp)G}duK1)oLL-1c,p,n;t,h;e.002;~ (t i0Hi < 100Hi++	podt;WN*T)Ws*t)(WyK-WxGhQpt += h;if (h&lt;e{ e(-e,en=e.yxxyxxxxxxyyyyyy)Gl dot(1,-rt- p n 0.c =(-Od.x*.2)+,l,l))-(t*Gif (Mp== hc =l-L,1t=0.;} }gl_FragColor4(cKlo(PGug(PGbf34962KcB()GeV(0GvA(J2K512JJJ0GbD,Int8Array.of=LLL6,6,035044GsetInterval(`g.Z1f(g.gf(PK"T"A++*Gg.dr(6KJ3G`K16G}';G=/[^	 -FIPSTV[-}]/.exec(_);)with(_.split(G))_=join(shift());eval(_)</pre>
          </div>
        </div>

        <!-- EXPANDED TAB -->
        <div class="tab-pane fade" id="tab-expanded" role="tabpanel" style="height:100%; overflow:hidden;">
          <div style="display:flex; flex-direction:column; height:100%;">
            <div class="p-2 border-bottom d-flex gap-2">
              <button id="runBtnExpanded" class="btn btn-outline-primary btn-sm" onClick="toggleRun('src-expanded')">&#9654; Run</button>
              <button class="btn btn-outline-secondary btn-sm" onClick="pauseDemo()">&#9646;&#9646; Pause</button>
            </div>
            <pre id="src-expanded" class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0;">var P = g.createProgram()

// Vertex shader: passes screen-space UV to the fragment shader
var vert = g.createShader(g.VERTEX_SHADER)
g.shaderSource(vert, `attribute vec2 p;
varying vec2 u;
void main() {
  gl_Position = vec4(u = p - 1., 0, 1);
}`)
g.compileShader(vert)
g.attachShader(P, vert)

// Fragment shader: raymarches the rotating tunnel scene
var frag = g.createShader(g.FRAGMENT_SHADER)
g.shaderSource(frag, `precision highp float;
varying vec2 u;
uniform float T;
#define rt vec2(sin(3. + T), cos(3. + T))

float bo(vec3 p) {
  p = abs(p - .5 * vec3(rt, 1));
  return max(max(p.x, p.y), p.z) - .1;
}

float s(vec3 p) {
  vec3 g = fract(vec3(p.xy, T + p.z) * 0.47) - .5;
  g = smoothstep(0.3, 1., 25. * g * g);
  float t = .25 * (5. - max(
    2.5 * (cos(p.x) * sin(T + p.z)) + length(g) + abs(p.x),
    length(g) + abs(1. - p.y)
  ));
  return min(t, bo(p));
}

void main() {
  vec3 d = normalize(vec3(u, 1)), o = vec3(0, 0, -1);
  vec3 c, p, n;
  float t, h;
  float e = .002;
  for (int i = 0; i &lt; 100; i++) {
    p = o + d * t;
    p.xy = cos(.05 * T) * p.xy + sin(.05 * t) * vec2(p.y, -p.x);
    h = s(p);
    t += h;
    if (h &lt; e) {
      vec2 e = vec2(-e, e);
      n = normalize(
        e.yxx * s(p + e.yxx) +
        e.xxy * s(p + e.xxy) +
        e.xyx * s(p + e.xyx) +
        e.yyy * s(p + e.yyy)
      );
      float l = max(dot(normalize(vec3(1, -rt) - p), n), 0.);
      c = (-abs(d.x * .2) + vec3(.5, l, l)) - (t * .05);
      if (bo(p) == h) c = l - vec3(0, .5, 1), t = 0.;
    }
  }
  gl_FragColor = vec4(c, 1);
}`)
g.compileShader(frag)
g.attachShader(P, frag)
g.linkProgram(P)
g.useProgram(P)

// Full-screen triangle: 3 BYTE vertices covering the entire viewport
var buf = g.createBuffer()
g.bindBuffer(g.ARRAY_BUFFER, buf)
g.bufferData(g.ARRAY_BUFFER, Int8Array.of(0, 0, 0, 6, 6, 0), g.STATIC_DRAW)
var loc = g.getAttribLocation(P, 'p')
g.enableVertexAttribArray(loc)
g.vertexAttribPointer(loc, 2, g.BYTE, false, 0, 0)

// Animate: increment T each frame and redraw
var T = 0
setInterval(function tick() {
  g.uniform1f(g.getUniformLocation(P, 'T'), T++ * .05)
  g.drawArrays(g.TRIANGLES, 0, 3)
}, 16)</pre>
          </div>
        </div>

        <!-- COMMENTED TAB -->
        <div class="tab-pane fade" id="tab-commented" role="tabpanel" style="height:100%; overflow:hidden;">
          <div style="display:flex; flex-direction:column; height:100%;">
            <div class="p-2 border-bottom d-flex gap-2">
              <button id="runBtnCommented" class="btn btn-outline-primary btn-sm" onClick="toggleRun('src-commented')">&#9654; Run</button>
              <button class="btn btn-outline-secondary btn-sm" onClick="pauseDemo()">&#9646;&#9646; Pause</button>
            </div>
            <div id="src-commented" class="p-3" style="flex:1; overflow:auto; min-height:0; font-family:monospace; font-size:20px; white-space:pre-wrap;"><div class="text-muted">// JS1K 2019 #4159 - "i feel fine" by Alexander Timoshenko
// Commented version: every line explained</div>

<div class="text-muted">// createProgram() returns a new empty program object that shaders attach to.</div>
var P = g.createProgram()

<div class="text-muted">/*
   VERTEX_SHADER = 35633.
   This shader runs once per vertex (3 times total for the full-screen triangle).
   It receives a 2D attribute p, computes clip-space position, and passes
   u = p - 1 as a varying so the fragment shader gets the screen-space UV.
 */</div>
var vert = g.createShader(g.VERTEX_SHADER)
g.shaderSource(vert, `attribute vec2 p;
varying vec2 u;
void main() {
  gl_Position = vec4(u = p - 1., 0, 1);
}`)
g.compileShader(vert)
g.attachShader(P, vert)

<div class="text-muted">/*
   FRAGMENT_SHADER = 35632.
   This shader runs once per pixel. It does all the rendering work —
   the entire tunnel scene is computed here on the GPU via raymarching.
 */</div>
var frag = g.createShader(g.FRAGMENT_SHADER)
g.shaderSource(frag, `precision highp float;
varying vec2 u;   <div class="text-muted">// screen UV passed from vertex shader</div>
uniform float T;  <div class="text-muted">// time value, incremented each frame by JS</div>

<div class="text-muted">/*
   rt is a rotating 2D unit vector driven by time T.
   It is reused in three places: the box SDF orientation,
   the light direction, and the camera twist — all from one define.
 */</div>
#define rt vec2(sin(3. + T), cos(3. + T))

<div class="text-muted">/*
   Box SDF: signed distance to an axis-aligned box centred at 0.5, half-size 0.1.
   The box xy axes are tilted by the rt rotation, so it slowly spins as T advances.
   Returns negative inside the box, zero on its surface, positive outside.
 */</div>
float bo(vec3 p) {
  p = abs(p - .5 * vec3(rt, 1));
  return max(max(p.x, p.y), p.z) - .1;
}

<div class="text-muted">/*
   Scene SDF: minimum distance to anything in the scene.
   fract(vec3(p.xy, T+p.z) * 0.47) - .5  tiles 3D space into repeating unit cells.
   smoothstep(0.3, 1., 25.*g*g)           sharpens tile edges into a mosaic pattern.
   The .25*(5. - max(...)) formula builds an inward-curved tunnel wall profile.
   min(t, bo(p)) unions the mosaic surface with the rotating inner box.
 */</div>
float s(vec3 p) {
  vec3 g = fract(vec3(p.xy, T + p.z) * 0.47) - .5;
  g = smoothstep(0.3, 1., 25. * g * g);
  float t = .25 * (5. - max(
    2.5 * (cos(p.x) * sin(T + p.z)) + length(g) + abs(p.x),
    length(g) + abs(1. - p.y)
  ));
  return min(t, bo(p));
}

void main() {
<div class="text-muted">  // Build a ray per pixel: direction d points into the screen, origin o is behind it.</div>
  vec3 d = normalize(vec3(u, 1)), o = vec3(0, 0, -1);
  vec3 c, p, n;
  float t,  <div class="text-muted">// accumulated distance marched along the ray</div>
        h;  <div class="text-muted">// SDF value at the current sample point</div>
  float e = .002; <div class="text-muted">// hit threshold: closer than this = surface</div>

<div class="text-muted">  /*
      Raymarching loop: take up to 100 steps.
      Each step is safe to advance by h (the SDF guarantees no overshoot).
   */</div>
  for (int i = 0; i &lt; 100; i++) {
    p = o + d * t;
<div class="text-muted">    /*
     * Twist: rotate p.xy by a small angle that grows with both T and t.
     * This makes the tunnel appear to corkscrew around the viewer over time.
     */</div>
    p.xy = cos(.05 * T) * p.xy + sin(.05 * t) * vec2(p.y, -p.x);
    h = s(p);
    t += h;
    if (h &lt; e) { <div class="text-muted">// hit — compute surface normal and colour</div>
<div class="text-muted">      /*
            Tetrahedron normal estimation: sample s() at 4 offset points.
            The swizzled sign patterns (yxx, xxy, xyx, yyy) form a tetrahedron.
            Their weighted sum approximates the gradient vector = surface normal.
       */</div>
      vec2 e = vec2(-e, e);
      n = normalize(
        e.yxx * s(p + e.yxx) +
        e.xxy * s(p + e.xxy) +
        e.xyx * s(p + e.xyx) +
        e.yyy * s(p + e.yyy)
      );
<div class="text-muted">      /*
            Diffuse term: dot product of normal with direction toward the light.
            The light is at vec3(1, -rt) — a point that orbits with the scene rotation.
       */</div>
      float l = max(dot(normalize(vec3(1, -rt) - p), n), 0.);
<div class="text-muted">      /*
            Base colour: teal-green shifted by diffuse l, darkened by fog (t*.05)
            and edge-darkened by abs(d.x*.2) for a vignette effect.
       */</div>
      c = (-abs(d.x * .2) + vec3(.5, l, l)) - (t * .05);
<div class="text-muted">      /*
            Box hits get a cyan-blue tint instead, and t resets so the ray
            continues past the box interior (tunnel-within-tunnel effect).
       */</div>
      if (bo(p) == h) c = l - vec3(0, .5, 1), t = 0.;
    }
  }
  gl_FragColor = vec4(c, 1); <div class="text-muted">// write final colour, fully opaque</div>
}`)
g.compileShader(frag)
g.attachShader(P, frag)
g.linkProgram(P)
g.useProgram(P)

<div class="text-muted">/*
   Upload geometry: a single full-screen triangle as 3 (x,y) BYTE vertex pairs.
   Vertices (0,0), (0,6), (6,0) — after the vertex shader subtracts 1 they become
   (-1,-1), (-1,5), (5,-1), a triangle large enough to cover the entire [-1,1] NDC viewport.
 */</div>
var buf = g.createBuffer()
g.bindBuffer(g.ARRAY_BUFFER, buf)
g.bufferData(g.ARRAY_BUFFER, Int8Array.of(0, 0, 0, 6, 6, 0), g.STATIC_DRAW)
var loc = g.getAttribLocation(P, 'p')
g.enableVertexAttribArray(loc)
g.vertexAttribPointer(loc, 2, g.BYTE, false, 0, 0)

<div class="text-muted">/*
   Animation: every 16ms upload the new time value and draw the triangle.
   T++ * .05 converts integer frame count to a slowly advancing float.
 */</div>
var T = 0
setInterval(function tick() {
  g.uniform1f(g.getUniformLocation(P, 'T'), T++ * .05)
  g.drawArrays(g.TRIANGLES, 0, 3)
}, 16)
</div>
          </div>
        </div>

        <!-- HTML TAB -->
        <div class="tab-pane fade" id="tab-html" role="tabpanel" style="height:100%; overflow:hidden;">
          <div style="display:flex; flex-direction:column; height:100%;">
            <div class="p-2 border-bottom text-muted" style="font-size:13px;">
              The HTML shim injected into the iframe for every tab. The tab&rsquo;s JavaScript is appended after the closing <code>&lt;/script&gt;</code>.
            </div>
            <pre class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0; font-size:20px;">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;meta charset="UTF-8"&gt;
  &lt;style&gt;
    * { margin: 0; padding: 0; box-sizing: border-box }
    body { background: #000 }
    canvas { display: none; position: absolute; top: 0; left: 0 }
  &lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;canvas id="c" width="512" height="512"&gt;&lt;/canvas&gt;
&lt;script&gt;
  var a = document.getElementById('c')
  var b = document.body
  var g = a.getContext('webgl') || a.getContext('experimental-webgl')
&lt;/script&gt;
&lt;!-- tab source injected here as a &lt;script&gt; tag after 3 seconds --&gt;
&lt;/body&gt;
&lt;/html&gt;</pre>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>

<script src="/Inc/js/bootstrap.js"></script>
<script>
var VERSION = '20'

var isRunning = false
var activeSourceId = 'src-original'
var currentBlobUrl = null
var lastInjectedHtml = ''

function revokeBlobUrl() {
  if (currentBlobUrl) {
    URL.revokeObjectURL(currentBlobUrl)
    currentBlobUrl = null
  }
}

function getRunBtn(sourceId) {
  if (sourceId === 'src-expanded') return document.getElementById('runBtnExpanded')
  return document.getElementById('runBtnCommented')
}

function setRunning(running, sourceId) {
  isRunning = running
  var btn = getRunBtn(sourceId)
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

function getDisplayCode(sourceId) {
  return document.getElementById(sourceId).textContent
}

function getExecutableCode(sourceId) {
  var el = document.getElementById(sourceId)
  if (sourceId === 'src-commented') {
    var clone = el.cloneNode(true)
    var muted = clone.querySelectorAll('.text-muted')
    for (var i = 0; i < muted.length; i += 1) {
      muted[i].parentNode.removeChild(muted[i])
    }
    return clone.textContent
  }
  return el.textContent
}

function buildShim(displayCode, runCode, pauseAfterFirstFrame) {
  var escapedDisplay = displayCode
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')

  var execCode = pauseAfterFirstFrame ? [
    '(function installPause() {',
    '  var real = window.setInterval.bind(window)',
    '  window.setInterval = function pausedSetInterval(fn, ms) {',
    '    var wrapped = (typeof fn === "string") ? function() { eval(fn) } : fn',
    '    var id = real(function runOnce() {',
    '      clearInterval(id)',
    '      wrapped()',
    '    }, ms)',
    '    return id',
    '  }',
    '}())',
    runCode
  ].join('\n') : runCode

  var encodedCode = btoa(unescape(encodeURIComponent(execCode)))

  return [
    '<!DOCTYPE html><html><head><meta charset="UTF-8">',
    '<style>',
    '* { margin:0; padding:0; box-sizing:border-box }',
    'body { background:#000; color:#0f0; font-family:monospace; font-size:13px; }',
    'canvas { display:none; position:absolute; top:0; left:0; }',
    '#code-display {',
    '  position:absolute; top:0; left:0; width:100%; height:100%;',
    '  overflow:auto; padding:12px; white-space:pre; line-height:1.5;',
    '  opacity:1; transition:opacity 0.5s;',
    '}',
    '.cm { color:#666; }',
    '#countdown {',
    '  position:fixed; bottom:10px; right:14px;',
    '  font-size:28px; font-weight:bold; color:#0f0;',
    '  opacity:0.8;',
    '}',
    '</style>',
    '</head><body>',
    '<canvas id="c" width="512" height="512"></canvas>',
    '<pre id="code-display">' + escapedDisplay + '</pre>',
    '<div id="countdown">3</div>',
    '<script>',
    'var a = document.getElementById("c")',
    'var b = document.body',
    'var g = a.getContext("webgl") || a.getContext("experimental-webgl")',
    'var display = document.getElementById("code-display")',
    'var countEl = document.getElementById("countdown")',
    'var seconds = 3',
    'var ticker = setInterval(function onTick() {',
    '  seconds -= 1',
    '  if (seconds > 0) {',
    '    countEl.textContent = seconds',
    '  } else {',
    '    clearInterval(ticker)',
    '    display.style.opacity = "0"',
    '    countEl.style.opacity = "0"',
    '    setTimeout(function onFade() {',
    '      display.style.display = "none"',
    '      a.style.display = "block"',
    '      var encoded = "' + encodedCode + '"',
    '      var decoded = decodeURIComponent(escape(atob(encoded)))',
    '      var s = document.createElement("script")',
    '      s.textContent = decoded',
    '      document.body.appendChild(s)',
    '    }, 500)',
    '  }',
    '}, 1000)',
    '<\/script>',
    '</body></html>'
  ].join('\n')
}

function loadIntoFrame(sourceId, pauseAfterFirstFrame) {
  var display = getDisplayCode(sourceId)
  var run = getExecutableCode(sourceId)
  var html = buildShim(display, run, pauseAfterFirstFrame)
  lastInjectedHtml = html
  var viewer = document.getElementById('html-viewer')
  if (viewer) viewer.textContent = html
  revokeBlobUrl()
  var blob = new Blob([html], { type: 'text/html' })
  currentBlobUrl = URL.createObjectURL(blob)
  var frame = document.getElementById('previewFrame')
  frame.src = currentBlobUrl
  frame.onload = function onFrameLoad() {
    frame.contentWindow.focus()
  }
}

function toggleRun(sourceId) {
  if (isRunning && activeSourceId === sourceId) {
    pauseDemo()
    return
  }
  if (activeSourceId !== sourceId) {
    setRunning(false, activeSourceId)
  }
  activeSourceId = sourceId
  loadIntoFrame(sourceId, false)
  setRunning(true, sourceId)
}

function pauseDemo() {
  loadIntoFrame(activeSourceId, true)
  setRunning(false, activeSourceId)
  isRunning = false
}

function resetDemo() {
  var ids = ['src-expanded', 'src-commented']
  for (var i = 0; i < ids.length; i += 1) {
    setRunning(false, ids[i])
  }
  isRunning = false
  activeSourceId = 'src-original'
  loadIntoFrame('src-original', true)
}

function showHtmlSource() {
  var viewer = document.getElementById('html-viewer')
  viewer.textContent = lastInjectedHtml || '(nothing injected yet)'
}

document.getElementById('codeTabs').addEventListener('shown.bs.tab', function onTabShown(e) {
  var target = e.target.getAttribute('data-bs-target')
  if (target === '#tab-about') {
    resetDemo()
  }
  if (target === '#tab-original' || target === '#tab-expanded' || target === '#tab-commented') {
    if (isRunning) resetDemo()
  }
  if (target === '#tab-html') {
    showHtmlSource()
  }
})

window.addEventListener('load', function onLoad() {
  activeSourceId = 'src-original'
  loadIntoFrame('src-original', true)
})
</script>
</body>
</html>
