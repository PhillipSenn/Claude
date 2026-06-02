<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JS1K 2013 Entry #1376 — Color Factors by Pablo Caro</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap/dist/css/bootstrap.css">
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
  <span class="navbar-brand mb-0 h1">JS1K 2013 Entry #1376 &mdash; Color Factors <small class="text-muted fs-6">by Pablo Caro &middot; 2013 &middot; 1019 bytes &middot; v10</small></span>
  <a href="/Claude/js1k" class="nav-link text-light ms-auto">JS1K</a>
</nav>

<div class="container-fluid p-0 full-height">
  <div class="row g-0 h-100">

    <!-- LEFT: iframe preview -->
    <div class="col-5 col-preview">
      <iframe id="previewFrame" src="about:blank" title="Color Factors preview"></iframe>
    </div>

    <!-- RIGHT: tabs -->
    <div class="col-7 code-col">

      <ul class="nav nav-tabs px-2 pt-1 bg-light" id="codeTabs" role="tablist">
        <li class="nav-item" role="presentation">
          <button class="nav-link active" id="tab-about-btn" data-bs-toggle="tab" data-bs-target="#tab-about" type="button" role="tab">About</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="tab-original-btn" data-bs-toggle="tab" data-bs-target="#tab-original" type="button" role="tab">Minified</button>
        </li>
        <li class="nav-item" role="presentation">
          <button class="nav-link" id="tab-expanded-btn" data-bs-toggle="tab" data-bs-target="#tab-expanded" type="button" role="tab">Original Source</button>
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
                <strong>Color Factors</strong> &mdash; JS1K 2013 Spring Entry #1376 &mdash; 1019 bytes
              </div>
              <div class="card-body">
                <p>An animated visualization of number theory: each integer is plotted as a point on a canvas and connected to all of its factors by arcs. Colors follow a spring rainbow; prime numbers are drawn in white because they have no factors.</p>
                <table class="table table-sm table-bordered">
                  <tbody>
                    <tr><th>Author</th><td>Pablo Caro Martín</td></tr>
                    <tr><th>Website</th><td><a href="http://pcaro.es" target="_blank">pcaro.es</a></td></tr>
                    <tr><th>Competition</th><td>classic</td></tr>
                    <tr><th>Year</th><td>2013 (Spring theme)</td></tr>
                    <tr><th>Bytes</th><td>1019 / 1024</td></tr>
                    <tr><th>Compression</th><td>Custom Python JSCompressor (based on JSCrush by Aivo Paas)</td></tr>
                  </tbody>
                </table>
                <p>Click anywhere on the canvas to activate <strong>TURBO MODE</strong>, which speeds up the animation dramatically.</p>
                <p>This entry is notable for including the full, heavily-commented original source on its js1k details page &mdash; a rarity in the competition. The original source even includes a variable name legend and three "cool facts" about the code.</p>
              </div>
            </div>

            <div class="card mb-3">
              <div class="card-header"><strong>How It Works</strong></div>
              <ul class="list-group list-group-flush">
                <li class="list-group-item">Numbers are added one at a time via <code>S()</code>, each placed at an equal horizontal spacing that shrinks as more numbers appear</li>
                <li class="list-group-item">For each new number <code>n+2</code>, the code checks every smaller number to find factors; matching indices are stored in <code>I[n]</code></li>
                <li class="list-group-item">If <code>I[n]</code> is empty the number is prime &mdash; a count <code>p</code> and last-prime tracker <code>l</code> are updated</li>
                <li class="list-group-item">Arcs are drawn using <code>setTransform</code> to stretch a unit circle into an ellipse connecting each number to its factors</li>
                <li class="list-group-item">The <code>C(x)</code> function maps an index 0&ndash;95 to an RGB rainbow, cycling through red &rarr; green &rarr; blue &rarr; red</li>
                <li class="list-group-item">Arc colors use <code>createLinearGradient</code> between the colors of the two connected points</li>
                <li class="list-group-item">The animation counter <code>r</code> runs 0&rarr;v each step; <code>setTimeout</code> drives the smooth entry of each new arc</li>
                <li class="list-group-item">Compressed to 1019 bytes (itself a prime number) using a custom Python compressor that finds optimal symbol substitution patterns</li>
              </ul>
            </div>

            <div class="card mb-3">
              <div class="card-header"><strong>Cool Facts (from the author)</strong></div>
              <div class="card-body" style="font-size:16px;">
                <p><strong>#1</strong> &mdash; Without leading spaces, every line in the description paragraph is exactly 70 characters long. 70's factors are 35, 14, 10, 7, 5, and 2.</p>
                <p><strong>#2</strong> &mdash; Primes only connect to points on their right (their multiples), never to the left, because they have no factors besides 1 and themselves.</p>
                <p><strong>#3</strong> &mdash; The most-used character in the uncompressed source is <code>i</code> with 74 appearances, followed by <code>(</code> and <code>)</code> tied at 73 each.</p>
              </div>
            </div>

          </div>
        </div>

        <!-- SOURCE TAB (minified submission) -->
        <div class="tab-pane fade" id="tab-original" role="tabpanel" style="height:100%; overflow:hidden;">
          <div style="display:flex; flex-direction:column; height:100%;">
            <div class="p-2 border-bottom d-flex gap-2 align-items-center">
              <button id="runBtnOriginal" class="btn btn-outline-primary btn-sm" onClick="toggleRun('src-original')">&#9654; Run</button>
              <button class="btn btn-outline-secondary btn-sm" onClick="resetDemo()">&#8635; Reset</button>
              <span class="text-muted ms-2" style="font-size:14px;">The minified js1k submission &mdash; 1019 bytes.</span>
            </div>
            <pre id="src-original" class="source-pre p-3 bg-dark text-light"
              data-b64="Xz0nHG0dZ2luThxvdmVyZmxvdz0iaGlkZGVuIjt3PWMud2lkdGgWV2lkdGg7aD1jLmgeFkgeO0Fmb250PSI3cHggHWlhbCI7ST1bXTtlPXcfO249LTE7cD1yPWY9ZD1pPWtOdj0xNztDGHglPTk2O3JldHVybiAicmdiKCIrKBlPfHwaGzY0Fy02NCtWGTcXN0VPBBk0OEI8TxdWGTY0FzY0RTQ4BBkbODAXOTYtVho3Fy03KwUpIn07UxhkPWUtdy8oEG4rMl9JBihbXV9pZgc+MCkgIGAHKxEfO2kQKWlmKAdKJU1KATApICACbl0GTV9yTjABAm5YBChwECxsPW4rMl91Azt1GGUtPWQvdjsQcjx2Pw5UaW1lb3V0KHUsETpTAzsOSW50ZXJ2YWwofmpTRD0iIzAwMCI7alJlY3QoMEZ3LGhfWSQoa05rPAJpWDtrECl7QW1vdmVUbyhaS19Bc2F2ZShfQQ5UcmFucyRtKE0tXikfRjAsKF5KHyxlKk0rXkofLEtVQR1jKDBGZUZNJTI/MTotESozLjE0Kk0Bbj9yL3Y6ESxpJTIBEkFyZXN0b3JlKF9RKiheKxFGWhJ6MCxDKF4TTSlfFFNEPWc7FANRRmUqbiwSYG47aSs9Tyl6aS9uLENNEwcpVVkwPHFnO2ooVVkwAXEiI2ZmZiI7aihfQG4VB0oPNBJAUHJpbWVzFXArIiAgTGFzdBVsDzgSMzx2BEBDbGljayAkIHR1cmJvISIPaC1PKX0sNBJjLm9uY2xpY2sYdj12PjM/MzoxN307UygpcQJpWARBHWMoWkssNEY4X2pTRBhmdW5jdGlvbih4KXt6Zy5hZGRDb2xvclN0b3AoYCRNTmk8akFmaWxsVV9BYmVnaW5QYXRoKF9WeCkqTzpRZz1BY3JlYXRlTGluZR1HcmFkaWVudChlXgJpXVtrXV8pO1hdLmxlbmd0aFlgPW47aRApWmUqTSsRLER0eWxlRS0FLCIrKBpGLDAsQGpUZXh0KCJBYS5CPzI1NTp4TShpTj0wO08xNkorMilLMypoLzU3MzIkZm9yFEFzdHJva2UVOiAiKxY9aW5uZXIXPygQKysRMSkSMF8TKV96MSxDHGIuc0QuHWFyHmVpZ2h0Hy8yGD1+GXg8Gng+PRs4MEI+PQQmJgVWMCkrIgYucHVzaAcobgE9PQJJWwMoKX0Oc2V0DyxPLCc7Zm9yKFk9MDskPSIPDgMCAQcGBQQbGhkYHx4dHBMSERAXFhUUJDdLSk9OTUJBQEZFRFpZWF9eUVZVamB6fnEiW1krK107KXdpdGgoXy5zcGxpdCgkKSlfPWpvaW4ocG9wKCkpO2V2YWwoXyk="
              style="flex:1; overflow:auto; height:auto; min-height:0; font-size:20px; white-space:pre-wrap; word-break:break-all;"><span class="text-muted">// Control characters (compression tokens) shown as \xNN</span>
_='<span class="text-muted">\x1c</span>m<span class="text-muted">\x1d</span>ginN<span class="text-muted">\x1c</span>overflow="hidden";w=c.width<span class="text-muted">\x16</span>Width;h=c.h<span class="text-muted">\x1e\x16</span>H<span class="text-muted">\x1e</span>;Afont="7px <span class="text-muted">\x1d</span>ial";I=[];e=w<span class="text-muted">\x1f</span>;n=-1;p=r=f=d=i=kNv=17;C<span class="text-muted">\x18</span>x%=96;return "rgb("+(<span class="text-muted">\x19</span>O||<span class="text-muted">\x1a\x1b</span>64<span class="text-muted">\x17</span>-64+V<span class="text-muted">\x19</span>7<span class="text-muted">\x17</span>7EO<span class="text-muted">\x04\x19</span>48B&lt;O<span class="text-muted">\x17</span>V<span class="text-muted">\x19</span>64<span class="text-muted">\x17</span>64E48<span class="text-muted">\x04\x19\x1b</span>80<span class="text-muted">\x17</span>96-V<span class="text-muted">\x1a</span>7<span class="text-muted">\x17</span>-7+<span class="text-muted">\x05</span>)"};S<span class="text-muted">\x18</span>d=e-w/(<span class="text-muted">\x10</span>n+2_I<span class="text-muted">\x06</span>([]_if<span class="text-muted">\x07</span>&gt;0)  `<span class="text-muted">\x07</span>+<span class="text-muted">\x11\x1f</span>;i<span class="text-muted">\x10</span>)if(<span class="text-muted">\x07</span>J%MJ<span class="text-muted">\x01</span>0)  <span class="text-muted">\x02</span>n]<span class="text-muted">\x06</span>M_rN0<span class="text-muted">\x01\x02</span>nX<span class="text-muted">\x04</span>(p<span class="text-muted">\x10</span>,l=n+2_u<span class="text-muted">\x03</span>;u<span class="text-muted">\x18</span>e-=d/v;<span class="text-muted">\x10</span>r&lt;v?<span class="text-muted">\x0e</span>Timeout(u,<span class="text-muted">\x11</span>:S<span class="text-muted">\x03</span>;<span class="text-muted">\x0e</span>Interval(~jSD="#000";jRect(0Fw,h_Y$(kNk&lt;<span class="text-muted">\x02</span>iX;k<span class="text-muted">\x10</span>){AmoveTo(ZK_Asave(_A<span class="text-muted">\x0e</span>Trans$m(M-^)<span class="text-muted">\x1f</span>F0,(^J<span class="text-muted">\x1f</span>,e*M+^J<span class="text-muted">\x1f</span>,KUA<span class="text-muted">\x1d</span>c(0FeFM%2?1:-<span class="text-muted">\x11</span>*3.14*M<span class="text-muted">\x01</span>n?r/v:<span class="text-muted">\x11</span>,i%2<span class="text-muted">\x01\x12</span>Arestore(_Q*(^+<span class="text-muted">\x11</span>FZ<span class="text-muted">\x12</span>z0,C(^<span class="text-muted">\x13</span>M)_<span class="text-muted">\x14</span>SD=g;<span class="text-muted">\x14\x03</span>QFe*n,<span class="text-muted">\x12</span>`n;i+=O)zi/n,CM<span class="text-muted">\x13\x07</span>)UY0&lt;qg;j(UY0<span class="text-muted">\x01</span>q"#fff";j(_@n<span class="text-muted">\x15\x07</span>J<span class="text-muted">\x0f</span>4<span class="text-muted">\x12</span>@Primes<span class="text-muted">\x15</span>p+"  Last<span class="text-muted">\x15</span>l<span class="text-muted">\x0f</span>8<span class="text-muted">\x12</span>3&lt;v<span class="text-muted">\x04</span>@Click $ turbo!"<span class="text-muted">\x0f</span>h-O)},4<span class="text-muted">\x12</span>c.onclick<span class="text-muted">\x18</span>v=v&gt;3?3:17};S()q<span class="text-muted">\x02</span>iX<span class="text-muted">\x04</span>A<span class="text-muted">\x1d</span>c(ZK,4F8_jSD<span class="text-muted">\x18</span>function(x){zg.addColorStop(`$MNi&lt;jAfillU_AbeginPath(_Vx)*O:Qg=AcreateLine<span class="text-muted">\x1d</span>Gradient(e^<span class="text-muted">\x02</span>i][k]_);X].lengthY`=n;i<span class="text-muted">\x10</span>)Ze*M+<span class="text-muted">\x11</span>,DtyleE-<span class="text-muted">\x05</span>,"+(<span class="text-muted">\x1a</span>F,0,@jText("Aa.B?255:xM(iN=0;O16J+2)K3*h/5732$for<span class="text-muted">\x14</span>Astroke<span class="text-muted">\x15</span>: "+<span class="text-muted">\x16</span>=inner<span class="text-muted">\x17</span>?(<span class="text-muted">\x10</span>++<span class="text-muted">\x11</span>1)<span class="text-muted">\x12</span>0_<span class="text-muted">\x13</span>)_z1,C<span class="text-muted">\x1c</span>b.sD.<span class="text-muted">\x1d</span>ar<span class="text-muted">\x1e</span>eight<span class="text-muted">\x1f</span>/2<span class="text-muted">\x18</span>=~<span class="text-muted">\x19</span>x&lt;<span class="text-muted">\x1a</span>x&gt;=<span class="text-muted">\x1b</span>80B&gt;=<span class="text-muted">\x04</span>&amp;&amp;<span class="text-muted">\x05</span>V0)+"<span class="text-muted">\x06</span>.push<span class="text-muted">\x07</span>(n<span class="text-muted">\x01</span>==<span class="text-muted">\x02</span>I[<span class="text-muted">\x03</span>()}<span class="text-muted">\x0e</span>set<span class="text-muted">\x0f</span>,O,';for(Y=0;$="<span class="text-muted">\x0f\x0e\x03\x02\x01\x07\x06\x05\x04\x1b\x1a\x19\x18\x1f\x1e\x1d\x1c\x13\x12\x11\x10\x17\x16\x15\x14</span>$7KJONMBA@FEDZYX_^QVUj`z~q"[Y++];)with(_.split($))_=join(pop());eval(_)</pre>
          </div>
        </div>

        <!-- ORIGINAL SOURCE TAB (author's readable source) -->
        <div class="tab-pane fade" id="tab-expanded" role="tabpanel" style="height:100%; overflow:hidden;">
          <div style="display:flex; flex-direction:column; height:100%;">
            <div class="p-2 border-bottom d-flex gap-2 align-items-center">
              <button id="runBtnExpanded" class="btn btn-outline-primary btn-sm" onClick="toggleRun('src-expanded')">&#9654; Run</button>
              <button class="btn btn-outline-secondary btn-sm" onClick="resetDemo()">&#8635; Reset</button>
              <span class="text-muted ms-2" style="font-size:14px;">Original source submitted by the author &mdash; fully commented.</span>
            </div>
            <pre id="src-expanded" class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0;">/***************************************************************************

    Color Factors - js1k 2013-Spring
    Pablo Caro Martín - pcaro.es

    Welcome to Color Factors!

    In this world, each point represents a number, starting from 2, to the
    infinite. Each one of these number is connected with its factors by an
    arc. The colors of the points come from a spring-like rainbow, and the
    arcs have a gradient that comes from the colors of the points they are
    connecting. However, all primes are white, just because they are cool.
    The "n" in the top-left corner indicates the last number, "primes" the
    number of prime numbers found, and "last" the last prime number found.
    If you click anywhere in the screen, the TURBO MODE will be activated!

    Cool fact #1: Without the leading spaces, all the lines in the above
        paragraph are 70 chars long. 70's factors are 35, 14, 10, 7, 5 and 2.

    Obvious examples:
        - 10 is connected with 5, 2, and with its multiples (20, 30, 40...)
        - 20 is connected to 10, 5 and 2 (and its multiples)
        - 30 is connected to 10, 6, 5, 3 and 2 (and its multiples)
        - 31 is only connected with it multiples, because it's prime.

    The demo has been tested in OS X, in the following browsers:
        - Chrome: Works nicely.
        - Safari: Works nicely.
        - Firefox: Works, but really slow after a few numbers are added.
        - Opera: Works well, after applying a workaround to avoid a fix
            regarding the transformation of arcs.

    In order to minify the code, I wrote my own "JSCompressor" in Python,
    based on the original JSCrush by Aivo Paas (www.iteral.com/jscrush), but
    with some functionalities that help when trying to find an optimal
    minimizable code, obtaining an even more reduced output. Everything
    else has been done manually, with some help from my JSCompressor script.

    After the compression, the code length is 1019 characters, which is a
    prime number. Nice.

    Cool fact #2: The obvious property of prime numbers (they don't have
        factors besides of 1 and themselves) leads to the fact that they are
        only connected with points in their right side, never in their left
        side.


    Names used (and where can that character be found):

        a: 2d context
        b: document body
        c: canvas element
        C: color function (addColorStop)
        d: dinc (innerWidth)
        e: inc (innerHeight)
        f: ninc (function)

        g: gradient (innerHeight)
        h: height (innerWidth)

        i: loop index (innerWidth)
        I: list of factors (setInterval)
        k: loop index (strokeStyle)
        l: last prime found (fillStyle)
        n: numbers (innerWidth)

        p: primes found (addColorStop)

        r: rinc (innerWidth)
        S: add_point function (addColorStop)
        u: movement function (function)
        v: movement increment
        w: width (innerWidth)
        x: aux (fillText)

    Cool fact #3: The most used character in this script before compression is
        "i", with 74 appearances; followed by "(" and ")", with 73 appearances
        each; and by "=" and ";", tied with 59 appearances each (without
        counting the comments!).

***************************************************************************/


    // No margins. No scroll. Stay cool.
    b.style.margin=0;
    b.style.overflow="hidden";
    w=c.width=innerWidth;
    h=c.height=innerHeight;
    a.font="32px arial";

    // Variable inicialization
    I=[];
    e=w/2;
    n=-1;
    p=r=f=d=i=k=0;
    v=132;

    // Rainbow color!
    C=function(x){
        x%=96;
        return "rgb("
            +(x&lt;16||x&gt;=80?255:x&gt;=64?(-64+x)*16:x&lt;32?(32-x)*16:0)+","
            +(x&gt;=16&amp;&amp;x&lt;48?255:x&lt;16?(x)*16:x&lt;64?(64-x)*16:0)+","
            +(x&gt;=48&amp;&amp;x&lt;80?255:x&gt;=80?(96-x)*16:x&gt;=32?(-32+x)*16:0)+")"
    };

    // Add a new value
    S=function(x){
        d=e-w/(++n+2);
        I.push([]);
        if(n&gt;0)  // Everyone loves 2
        for(i=0;i&lt;(n+1)/2;i++)
            if((n+2)%(i+2)==0)  // Join with every factor
            // if((n+2)%(i+2)==0&amp;&amp;I[i].length==0) // Join with primes only
                I[n].push(i);
        r=0;
        0==I[n].length&amp;&amp;(p++,l=n+2);
        u()
    };

    // Movement
    u=function(x){
        e-=d/v;
        ++r&lt;v?setTimeout(u,1):S()
    };

    // Drawing function
    setInterval(function(x){
        a.fillStyle="#000";
        a.fillRect(0,0,w,h);

        // Arcs
        for(i=0;i&lt;=n;i++)
            for(k=0;k&lt;I[i].length;k++){
                a.moveTo(e*(i+1),3*h/5);
                a.save();
                a.setTransform(
                    (i-I[i][k])/2,0,0,
                    (I[i][k]+2)/2,e*(i+I[i][k]+2)/2,3*h/5);
                a.beginPath();
                a.arc(0,0,e,0,(i%2?1:-1)*3.14*(i==n?r/v:1),i%2==0);
                a.restore();
                g=a.createLinearGradient(e*(I[i][k]+1),0,e*(i+1),0);
                g.addColorStop(0,C(I[i][k]));
                g.addColorStop(1,C(i));
                a.strokeStyle=g;
                a.stroke()
            }

        g=a.createLinearGradient(e,0,e*n,0);
        for(i=0;i&lt;n;i+=16)
            g.addColorStop(i/n,C(i));
        g.addColorStop(1,C(n));

        // Color points (non primes)
        a.beginPath();
        for(i=0;i&lt;=n;i++)
            0&lt;I[i].length&amp;&amp;a.arc(e*(i+1),3*h/5,4,0,8);
        a.fillStyle=g;
        a.fill();

        // White points (primes)
        a.beginPath();
        for(i=0;i&lt;=n;i++)
            0==I[i].length&amp;&amp;a.arc(e*(i+1),3*h/5,4,0,8);
        a.fillStyle="#fff";
        a.fill();

        a.fillText("n: "+(n+2),16,40);
        a.fillText("Primes: "+p+"  Last: "+l,16,80);
        3&lt;v&amp;&amp;a.fillText("Click for turbo!",16,h-16)
    },40);

    c.onclick=function(x){v=v&gt;3?3:132};

    S()</pre>
          </div>
        </div>

        <!-- HTML TAB -->
        <div class="tab-pane fade" id="tab-html" role="tabpanel" style="height:100%; overflow:hidden;">
          <div style="display:flex; flex-direction:column; height:100%;">
            <div class="p-2 border-bottom text-muted" style="font-size:13px;">
              The HTML shim injected into the iframe. The tab&rsquo;s JavaScript is appended after the closing <code>&lt;/script&gt;</code>.
            </div>
            <pre class="source-pre p-3 bg-dark text-light" style="flex:1; overflow:auto; height:auto; min-height:0; font-size:20px;">&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
  &lt;meta charset="UTF-8"&gt;
  &lt;style&gt;
    * { margin: 0; padding: 0; box-sizing: border-box }
    body { background: #000 }
    canvas { display: block; position: absolute; top: 0; left: 0 }
  &lt;/style&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;canvas id="c"&gt;&lt;/canvas&gt;
&lt;script&gt;
  var c = document.getElementById('c')
  var b = document.body
  var a = c.getContext('2d')
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap/dist/js/bootstrap.bundle.js"></script>
<script>
var VERSION = '10'

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
  return document.getElementById('runBtnOriginal')
}

function setRunning(running, sourceId) {
  isRunning = running
  var btn = getRunBtn(sourceId)
  if (!btn) return
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
  var b64 = el.getAttribute('data-b64')
  if (b64) return { type: 'b64', value: b64 }
  return { type: 'text', value: el.textContent }
}

function buildShim(displayCode, runCode, singleFrame) {
  var escapedDisplay = displayCode
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')

  var runExpr
  var pauseCode = singleFrame ? [
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
    '}())'
  ].join('\n') : ''

  if (runCode.type === 'b64') {
    var b64Json = JSON.stringify(runCode.value)
    var pauseJson = JSON.stringify(pauseCode)
    runExpr = [
      'var _src = atob(' + b64Json + ')',
      'new Function("a","b","c", ' + (singleFrame ? pauseJson + ' + "\\n" + ' : '') + '_src)(a, b, c)'
    ].join('\n      ')
  } else {
    var execCode = singleFrame ? pauseCode + '\n' + runCode.value : runCode.value
    runExpr = 'new Function("a","b","c", ' + JSON.stringify(execCode) + ')(a, b, c)'
  }

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
    '#countdown {',
    '  position:fixed; bottom:10px; right:14px;',
    '  font-size:28px; font-weight:bold; color:#0f0;',
    '  opacity:0.8;',
    '}',
    '</style>',
    '</head><body>',
    '<canvas id="c"></canvas>',
    '<pre id="code-display">' + escapedDisplay + '</pre>',
    '<div id="countdown">3</div>',
    '<script>',
    'var c = document.getElementById("c")',
    'var b = document.body',
    'var a = c.getContext("2d")',
    'c.width = window.innerWidth',
    'c.height = window.innerHeight',
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
    '      c.style.display = "block"',
    '      ' + runExpr,
    '    }, 500)',
    '  }',
    '}, 1000)',
    '<\/script>',
    '</body></html>'
  ].join('\n')
}

function loadIntoFrame(sourceId, singleFrame) {
  var display = getDisplayCode(sourceId)
  var run = getExecutableCode(sourceId)
  var html = buildShim(display, run, singleFrame)
  lastInjectedHtml = html
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
    resetDemo()
    return
  }
  if (activeSourceId !== sourceId) {
    setRunning(false, activeSourceId)
  }
  activeSourceId = sourceId
  loadIntoFrame(sourceId, false)
  setRunning(true, sourceId)
}

function resetDemo() {
  setRunning(false, activeSourceId)
  isRunning = false
  activeSourceId = 'src-original'
  loadIntoFrame('src-original', true)
}

function showHtmlSource() {
  var viewer = document.getElementById('html-viewer')
  if (viewer) viewer.textContent = lastInjectedHtml || '(nothing injected yet)'
}

document.getElementById('codeTabs').addEventListener('shown.bs.tab', function onTabShown(e) {
  var target = e.target.getAttribute('data-bs-target')
  if (target === '#tab-about') {
    resetDemo()
  }
  if (target === '#tab-original' || target === '#tab-expanded') {
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
