<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JS1K 2425 &mdash; Recursive Tree</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inconsolata:wght@400;600&family=Spectral:ital,wght@0,400;0,600;1,400&display=swap" rel="stylesheet">
<style>
  :root {
    --bg:       #0e120d;
    --surface:  #151a13;
    --border:   #2a3328;
    --green:    #4e9a57;
    --green-hi: #7ec982;
    --amber:    #c8963a;
    --muted:    #5a6e58;
    --text:     #cdd8cb;
    --heading:  #e8f0e6;
  }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body {
    background: var(--bg);
    color: var(--text);
    font-family: 'Spectral', Georgia, serif;
    font-size: 16px;
    line-height: 1.7;
  }

  /* ── Layout ── */
  .page { max-width: 860px; margin: 0 auto; padding: 3rem 1.5rem 6rem; }

  /* ── Header ── */
  .hdr { border-bottom: 1px solid var(--border); padding-bottom: 1.5rem; margin-bottom: 2.5rem; }
  .hdr-meta { font-family: 'Inconsolata', monospace; font-size: 0.8rem; color: var(--muted); letter-spacing: .08em; text-transform: uppercase; margin-bottom: .6rem; }
  .hdr-meta a { color: var(--muted); text-decoration: none; }
  .hdr-meta a:hover { color: var(--green-hi); }
  .hdr h1 { font-family: 'Spectral', serif; font-size: 2rem; font-weight: 600; color: var(--heading); line-height: 1.2; }
  .hdr-sub { margin-top: .5rem; color: var(--muted); font-style: italic; font-size: .95rem; }

  /* ── Section titles ── */
  .sec-title {
    font-family: 'Inconsolata', monospace;
    font-size: .75rem;
    font-weight: 600;
    letter-spacing: .15em;
    text-transform: uppercase;
    color: var(--amber);
    margin-bottom: 1rem;
    display: flex;
    align-items: center;
    gap: .6rem;
  }
  .sec-title::after { content: ''; flex: 1; height: 1px; background: var(--border); }

  /* ── Demo canvas block ── */
  .demo-wrap {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 2.5rem;
  }
  .demo-wrap canvas {
    display: block;
    width: 100%;
    cursor: pointer;
  }

  /* ── Prose ── */
  .prose { margin-bottom: 2.5rem; }
  .prose p { margin-bottom: 1rem; }
  .prose p:last-child { margin-bottom: 0; }
  code {
    font-family: 'Inconsolata', monospace;
    font-size: .88em;
    background: #1b2219;
    border: 1px solid var(--border);
    border-radius: 3px;
    padding: .1em .35em;
    color: var(--green-hi);
  }

  /* ── Code blocks ── */
  .code-block {
    background: #111610;
    border: 1px solid var(--border);
    border-radius: 4px;
    overflow-x: auto;
    margin-bottom: 2.5rem;
  }
  .code-block pre {
    font-family: 'Inconsolata', monospace;
    font-size: .85rem;
    line-height: 1.6;
    padding: 1.4rem 1.6rem;
    color: var(--text);
  }
  /* syntax-ish coloring via span */
  .kw  { color: #7ec982; }   /* keywords */
  .fn  { color: #c8963a; }   /* function names */
  .str { color: #8fbe78; }   /* strings */
  .num { color: #9ecfff; }   /* numbers */
  .cm  { color: #4a5e48; font-style: italic; } /* comments */

  /* ── Expanded canvas block ── */
  .expanded-wrap {
    background: var(--surface);
    border: 1px solid var(--border);
    border-radius: 4px;
    overflow: hidden;
    margin-bottom: 2.5rem;
  }
  .expanded-wrap canvas {
    display: block;
    width: 100%;
    cursor: pointer;
  }
  .canvas-caption {
    font-family: 'Inconsolata', monospace;
    font-size: .75rem;
    color: var(--muted);
    padding: .5rem 1rem;
    border-top: 1px solid var(--border);
    text-align: center;
  }
</style>
</head>
<body>
<div class="page">

  <!-- Header -->
  <header class="hdr">
    <div class="hdr-meta">
      <a href="js1k_entries.cfm">← all entries</a>
      &nbsp;/&nbsp;
      <a href="https://js1k.com/2016-elemental/demo/2425" target="_blank" rel="noopener">js1k.com/2425</a>
      &nbsp;/&nbsp; 2016 · eleMental · 632 bytes
    </div>
    <h1>Recursive Tree</h1>
    <p class="hdr-sub">by LuisQuin &mdash; a random tree grown through recursive branching on HTML5 Canvas</p>
  </header>

  <!-- SUBMISSION -->
  <div class="sec-title">Submission</div>
  <div class="demo-wrap">
    <canvas id="c1" width="800" height="400"></canvas>
    <div class="canvas-caption">click to regenerate</div>
  </div>

  <div class="sec-title">Submission source <span style="color:var(--muted);font-size:.7rem;letter-spacing:0;text-transform:none;font-family:'Spectral',serif;font-style:italic">&nbsp;632 bytes</span></div>
  <div class="code-block"><pre>for(_='"rgb(roundon()functi{l,m/2,extn,p,A,Style=;b.stroke";c.[TAB]Math.random"+(64*+b.height>>0)+",
line,b.width);d;g(c.75*,60,-PI12,12)( d{c.fill"black[TAB]ft="bold 16px Arial[TAB]tAlign="center
[TAB]fillT("Click  image to regenerate tree"50)} g(b,c,e,h,k,d,f){var ,r=2*PI/4beginPathmoveTo(c,e);
l=c+h*cos(k);m=e+h*sin(k)Cap=""Width=fTo()2>=d?0, 1280)":6450, 25)";if(A=d-1)for(c=(2*)+1,f*=.7,
e=0;e<c;e++)p=k+*r-.5*r,n=h*(.7+.3*),setTimeout(g(b,,f)},30)}var b=a,c=b.getCt("2d"click=
c.clearRect(0,0,}});';g=/[-]/.exec(_);)with(_.split(g))_=join(shift());eval(_)</pre></div>

  <!-- EXPANDED -->
  <div class="sec-title">Expanded</div>
  <p class="prose">The submission uses a string-substitution compressor: a dictionary of common substrings is prepended to a template, each entry separated by the control character it replaces. The loop finds the first control character, promotes the text before it into a replacement, and repeats until the template is clean JavaScript. What follows is the decompressed result &mdash; 784 characters, still compact but now readable.</p>

  <div class="expanded-wrap">
    <canvas id="c2" width="800" height="400"></canvas>
    <div class="canvas-caption">click to regenerate</div>
  </div>

  <div class="sec-title">Expanded source <span style="color:var(--muted);font-size:.7rem;letter-spacing:0;text-transform:none;font-family:'Spectral',serif;font-style:italic">&nbsp;784 bytes</span></div>
  <div class="code-block"><pre>(function(){
  function d(){
    c.fillStyle="black";
    c.font="bold 16px Arial";
    c.textAlign="center";
    c.fillText("Click on image to regenerate tree",b.width/2,50)
  }

  function g(b,c,e,h,k,d,f){
    var n,p,A,l,m,r=2*Math.PI/4;
    b.beginPath();
    b.moveTo(c,e);
    l=c+h*Math.cos(k);
    m=e+h*Math.sin(k);
    b.lineCap="round";
    b.lineWidth=f;
    b.lineTo(l,m);
    b.strokeStyle=2>=d
      ?"rgb(0, "+(64*Math.random()+128>>0)+", 0)"
      :"rgb("+(64*Math.random()+64>>0)+", 50, 25)";
    b.stroke();
    if(A=d-1)
      for(c=Math.round(2*Math.random())+1,f*=.7,e=0;e&lt;c;e++)
        p=k+Math.random()*r-.5*r,
        n=h*(.7+.3*Math.random()),
        setTimeout(function(){g(b,l,m,n,p,A,f)},30)
  }

  var b=a,c=b.getContext("2d");
  d();
  g(c,b.width/2,.75*b.height,60,-Math.PI/2,12,12);
  b.onclick=function(){c.clearRect(0,0,b.width,b.height);d();g(c,b.width/2,.75*b.height,60,-Math.PI/2,12,12)}
})();</pre></div>

  <!-- COMMENTED -->
  <div class="sec-title">Commented</div>
  <p class="prose">The tree grows by recursion via <code>setTimeout</code>. Each call to <code>g()</code> draws one branch segment, then schedules 1 or 2 child branches at random angles. Recursion stops when depth <code>d</code> reaches zero. Branches at depth &le;2 are drawn green; deeper ones use a warm reddish-brown, mimicking bark. The <code>lineWidth</code> shrinks by 30% at each level, so trunk segments are thick and twigs are hair-thin.</p>

  <div class="code-block"><pre><span class="cm">// js1k shim provides: a=canvas, b=document.body, c=2d context, d=document
// The submission wraps everything in an IIFE to avoid polluting global scope.</span>

(function(){

  <span class="cm">// ── Prompt text ─────────────────────────────────────────────────────────────
  // Draws "Click on image to regenerate tree" near the top of the canvas.
  // Called once on load and again after each click-clear.</span>
  <span class="kw">function</span> <span class="fn">d</span>(){
    c.fillStyle = <span class="str">"black"</span>;
    c.font      = <span class="str">"bold 16px Arial"</span>;
    c.textAlign = <span class="str">"center"</span>;
    c.fillText(<span class="str">"Click on image to regenerate tree"</span>, b.width/<span class="num">2</span>, <span class="num">50</span>);
  }

  <span class="cm">// ── Branch drawing / recursion ───────────────────────────────────────────────
  // Parameters:
  //   b  – canvas element (used for .onclick and dimensions)
  //   c  – 2d context
  //   e  – start Y (note: variable shadowing – 'e' re-used from outer scope)
  //   h  – segment length in pixels
  //   k  – angle in radians (starts at -PI/2 = straight up)
  //   d  – remaining depth (12 on first call; recursion stops at 0)
  //   f  – line width (12 on first call; shrinks by ×0.7 each level)</span>
  <span class="kw">function</span> <span class="fn">g</span>(b, c, e, h, k, d, f){
    <span class="kw">var</span> n, p, A, l, m;
    <span class="kw">var</span> r = <span class="num">2</span> * Math.PI / <span class="num">4</span>;  <span class="cm">// = PI/2 – the maximum random deviation per branch</span>

    <span class="cm">// Draw the segment from (c,e) to (l,m)</span>
    b.beginPath();
    b.moveTo(c, e);
    l = c + h * Math.cos(k);   <span class="cm">// tip X</span>
    m = e + h * Math.sin(k);   <span class="cm">// tip Y</span>

    b.lineCap   = <span class="str">"round"</span>;     <span class="cm">// rounded ends look organic</span>
    b.lineWidth = f;
    b.lineTo(l, m);

    <span class="cm">// Color: near-leaf branches (depth ≤ 2) → green; deeper → reddish-brown bark</span>
    b.strokeStyle = (<span class="num">2</span> >= d)
      ? <span class="str">"rgb(0, "</span>  + (<span class="num">64</span> * Math.random() + <span class="num">128</span> >> <span class="num">0</span>) + <span class="str">", 0)"</span>    <span class="cm">// green, 128–191</span>
      : <span class="str">"rgb("</span>     + (<span class="num">64</span> * Math.random() + <span class="num">64</span>  >> <span class="num">0</span>) + <span class="str">", 50, 25)"</span>; <span class="cm">// brown, 64–127</span>
    b.stroke();

    <span class="cm">// Recurse: if depth remains (A = d-1 is truthy while d > 1)</span>
    <span class="kw">if</span> (A = d - <span class="num">1</span>) {
      <span class="cm">// Pick how many child branches: 1 or 2 (Math.round(2*random())+1 → 1, 2, or 3 but
      // weighted to 1–2). Each child is delayed 30ms so the tree "grows" visibly.</span>
      <span class="kw">for</span> (
        c = Math.round(<span class="num">2</span> * Math.random()) + <span class="num">1</span>,  <span class="cm">// reuse 'c' as branch count (1–3)</span>
        f *= .<span class="num">7</span>,                                  <span class="cm">// thin the line by 30%</span>
        e = <span class="num">0</span>;
        e < c;
        e++
      ) {
        p = k + Math.random() * r - .<span class="num">5</span> * r;        <span class="cm">// new angle: parent ± up to PI/4</span>
        n = h * (.<span class="num">7</span> + .<span class="num">3</span> * Math.random());         <span class="cm">// new length: 70–100% of parent's</span>
        setTimeout(<span class="kw">function</span>(){
          g(b, l, m, n, p, A, f);                 <span class="cm">// branch from tip (l,m)</span>
        }, <span class="num">30</span>);
      }
    }
  }

  <span class="cm">// ── Bootstrap ────────────────────────────────────────────────────────────────
  // js1k shim already put the canvas in 'a'; grab context and kick off the tree.</span>
  <span class="kw">var</span> b = a,
      c = b.getContext(<span class="str">"2d"</span>);

  d();  <span class="cm">// draw prompt text</span>
  g(c, b.width/<span class="num">2</span>, .<span class="num">75</span> * b.height, <span class="num">60</span>, -Math.PI/<span class="num">2</span>, <span class="num">12</span>, <span class="num">12</span>);
  <span class="cm">// ^ starts at horizontal centre, 75% down, length 60px, pointing straight up, depth 12, width 12</span>

  b.onclick = <span class="kw">function</span>(){
    c.clearRect(<span class="num">0</span>, <span class="num">0</span>, b.width, b.height);  <span class="cm">// wipe canvas</span>
    d();                                       <span class="cm">// redraw prompt</span>
    g(c, b.width/<span class="num">2</span>, .<span class="num">75</span> * b.height, <span class="num">60</span>, -Math.PI/<span class="num">2</span>, <span class="num">12</span>, <span class="num">12</span>);
  };

})();</pre></div>

</div><!-- .page -->

<script>
// Run the tree on both canvases.
// The original js1k shim exposes: a=canvas, b=body, c=ctx, d=document.
// We replicate that contract here for each canvas.

function runTree(canvasEl) {
  var a = canvasEl
  var b = canvasEl
  var c = canvasEl.getContext('2d')

  function drawPrompt() {
    c.fillStyle = 'rgba(180,220,170,0.55)'
    c.font = 'bold 14px Inconsolata, monospace'
    c.textAlign = 'center'
    c.fillText('Click to regenerate', canvasEl.width / 2, 28)
  }

  function branch(ctx, x, y, length, angle, depth, width) {
    if (depth <= 0) return
    var r = 2 * Math.PI / 4
    ctx.beginPath()
    ctx.moveTo(x, y)
    var tx = x + length * Math.cos(angle)
    var ty = y + length * Math.sin(angle)
    ctx.lineCap = 'round'
    ctx.lineWidth = width
    ctx.lineTo(tx, ty)
    ctx.strokeStyle = (2 >= depth)
      ? 'rgb(0, ' + (64 * Math.random() + 128 >> 0) + ', 0)'
      : 'rgb(' + (64 * Math.random() + 64 >> 0) + ', 50, 25)'
    ctx.stroke()
    var A = depth - 1
    if (A) {
      var count = Math.round(2 * Math.random()) + 1
      var newWidth = width * 0.7
      for (var i = 0; i < count; i++) {
        var newAngle = angle + Math.random() * r - 0.5 * r
        var newLen = length * (0.7 + 0.3 * Math.random())
        ;(function(bx, by, bl, ba, bd, bw) {
          setTimeout(function() {
            branch(ctx, bx, by, bl, ba, bd, bw)
          }, 30)
        })(tx, ty, newLen, newAngle, A, newWidth)
      }
    }
  }

  function grow() {
    c.clearRect(0, 0, canvasEl.width, canvasEl.height)
    drawPrompt()
    branch(c, canvasEl.width / 2, 0.75 * canvasEl.height, 60, -Math.PI / 2, 12, 12)
  }

  grow()
  canvasEl.onclick = grow
}

// Size canvases to container width, maintain aspect ratio
function initCanvas(id) {
  var el = document.getElementById(id)
  var wrapper = el.parentElement
  var w = wrapper.clientWidth
  el.width = w
  el.height = Math.round(w * 0.5)
  runTree(el)
}

window.addEventListener('load', function() {
  initCanvas('c1')
  initCanvas('c2')
})
</script>
</body>
</html>
