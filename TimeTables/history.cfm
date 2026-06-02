
<style>
h2.sr-only{position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap}
#tl-wrap{width:100%;overflow:hidden;position:relative;background:var(--color-background-tertiary);border-radius:var(--border-radius-lg);border:0.5px solid var(--color-border-tertiary)}
#tl-controls{display:flex;align-items:center;gap:8px;padding:10px 12px;border-bottom:0.5px solid var(--color-border-tertiary);background:var(--color-background-primary);border-radius:var(--border-radius-lg) var(--border-radius-lg) 0 0;flex-wrap:wrap}
.tl-btn{background:transparent;border:0.5px solid var(--color-border-secondary);border-radius:var(--border-radius-md);padding:4px 10px;font-size:13px;cursor:pointer;color:var(--color-text-primary)}
.tl-btn:hover{background:var(--color-background-secondary)}
#tl-label{font-size:12px;color:var(--color-text-secondary);margin-left:auto}
#tl-detail{padding:10px 14px;font-size:13px;color:var(--color-text-secondary);min-height:36px;border-top:0.5px solid var(--color-border-tertiary);background:var(--color-background-secondary);border-radius:0 0 var(--border-radius-lg) var(--border-radius-lg);line-height:1.5}
.legend{display:flex;flex-wrap:wrap;gap:8px;padding:6px 12px 8px;background:var(--color-background-primary);border-bottom:0.5px solid var(--color-border-tertiary)}
.leg-item{display:flex;align-items:center;gap:4px;font-size:11px;color:var(--color-text-secondary)}
.leg-swatch{width:10px;height:10px;border-radius:2px;flex-shrink:0}
table#tl-table{border-collapse:collapse;table-layout:fixed}
table#tl-table th{position:sticky;top:0;background:var(--color-background-secondary);font-size:11px;font-weight:500;color:var(--color-text-secondary);padding:4px 0;text-align:center;border-right:0.5px solid var(--color-border-tertiary);border-bottom:1px solid var(--color-border-secondary);z-index:10;white-space:nowrap;overflow:hidden}
table#tl-table th.row-hdr{position:sticky;left:0;z-index:20;background:var(--color-background-secondary);min-width:48px;width:48px}
table#tl-table td.row-hdr{position:sticky;left:0;background:var(--color-background-secondary);font-size:11px;font-weight:500;color:var(--color-text-secondary);padding:0 4px;text-align:right;border-right:1px solid var(--color-border-secondary);z-index:5;min-width:48px;white-space:nowrap}
.tl-cell{width:52px;height:28px;border-right:0.5px solid rgba(128,128,128,0.15);border-bottom:0.5px solid rgba(128,128,128,0.15);cursor:pointer;position:relative;overflow:hidden}
.tl-cell:hover{outline:1.5px solid var(--color-border-primary);z-index:3}
.tl-cell .dot-wrap{position:absolute;inset:0;display:flex;align-items:center;justify-content:center;gap:2px;padding:2px}
.tl-dot{width:5px;height:5px;border-radius:50%;flex-shrink:0}
.cell-label{position:absolute;bottom:1px;left:2px;right:2px;font-size:8px;color:rgba(255,255,255,0.85);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;pointer-events:none}
</style>
<h2 class="sr-only">Interactive history timeline grid from 1800 to 1960. Rows are years, columns are months. Click any cell to explore events.</h2>
<div id="tl-wrap">
  <div id="tl-controls">
    <button class="tl-btn" id="btn-zoom-in"><i class="ti ti-zoom-in" aria-hidden="true"></i></button>
    <button class="tl-btn" id="btn-zoom-out"><i class="ti ti-zoom-out" aria-hidden="true"></i></button>
    <button class="tl-btn" id="btn-reset">Reset</button>
    <span id="tl-label">Ctrl+scroll to zoom &middot; Click a cell to explore</span>
  </div>
  <div class="legend">
    <div class="leg-item"><div class="leg-swatch" style="background:#6b3a3a"></div>War / conflict</div>
    <div class="leg-item"><div class="leg-swatch" style="background:#2a4a6b"></div>Politics / empires</div>
    <div class="leg-item"><div class="leg-swatch" style="background:#2d5a3d"></div>Science / exploration</div>
    <div class="leg-item"><div class="leg-swatch" style="background:#5a3a6b"></div>Culture / religion</div>
    <div class="leg-item"><div class="leg-swatch" style="background:#6b5a2a"></div>Economy / trade</div>
    <div class="leg-item"><div class="leg-swatch" style="background:#1a1010"></div>Major war era</div>
  </div>
  <div style="overflow:auto;max-height:500px" id="tl-scroll">
    <table id="tl-table"><thead></thead><tbody></tbody></table>
  </div>
  <div id="tl-detail">Click any cell to see what was happening in that month and year.</div>
</div>
<script>
var START_YEAR = 1800
var END_YEAR = 1960
var MONTHS = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']

var EVENTS = {
  '1803-4': {label:'Louisiana Purchase', cat:'politics', detail:'The US purchases ~828,000 sq mi from France, doubling the size of the nation.'},
  '1803-6': {label:'Lewis & Clark', cat:'science', detail:'Lewis and Clark Expedition departs to explore the Louisiana Territory.'},
  '1804-12': {label:'Napoleon crowned', cat:'politics', detail:'Napoleon crowns himself Emperor of the French at Notre-Dame Cathedral.'},
  '1805-10': {label:'Trafalgar', cat:'war', detail:'Battle of Trafalgar — Britain defeats the Franco-Spanish fleet; Nelson killed.'},
  '1807-3': {label:'Slave Trade Act', cat:'politics', detail:'Britain abolishes the transatlantic slave trade with the Slave Trade Act 1807.'},
  '1812-6': {label:'War of 1812', cat:'war', detail:'United States declares war on Britain. Fighting erupts along the Canadian border.'},
  '1812-9': {label:'Moscow burns', cat:'war', detail:'Napoleon enters Moscow to find it ablaze. The Russian campaign turns catastrophic.'},
  '1815-6': {label:'Waterloo', cat:'war', detail:'Napoleon defeated by Wellington and Blucher at Waterloo; exiled to St Helena.'},
  '1819-1': {label:'Florida ceded', cat:'politics', detail:'Adams-Onis Treaty — Spain cedes Florida to the United States.'},
  '1823-12': {label:'Monroe Doctrine', cat:'politics', detail:'President Monroe declares the Western Hemisphere off-limits to European colonization.'},
  '1825-9': {label:'Steam railway', cat:'science', detail:'Stockton and Darlington Railway opens — the first public steam-hauled railway.'},
  '1830-7': {label:'French Revolution', cat:'politics', detail:'July Revolution in France. Charles X abdicates; Louis-Philippe becomes Citizen King.'},
  '1833-8': {label:'Slavery abolished', cat:'politics', detail:'Slavery Abolition Act passed in Britain, freeing ~800,000 enslaved people.'},
  '1836-3': {label:'Fall of the Alamo', cat:'war', detail:'Mexican forces storm the Alamo. All defenders killed.'},
  '1837-6': {label:'Victoria crowned', cat:'politics', detail:'Queen Victoria ascends to the British throne, beginning a 63-year reign.'},
  '1839-10': {label:'Opium War', cat:'war', detail:'First Opium War begins between Britain and Qing China.'},
  '1844-5': {label:'Telegraph', cat:'science', detail:'Samuel Morse sends the first long-distance telegraph message.'},
  '1845-9': {label:'Irish Famine', cat:'economy', detail:'Potato blight devastates Ireland. Over the next decade ~1M die; ~1M emigrate.'},
  '1848-2': {label:'Communist Manifesto', cat:'culture', detail:'Marx and Engels publish The Communist Manifesto in London.'},
  '1848-3': {label:'Revolutions 1848', cat:'politics', detail:'Wave of revolutions sweeps Europe — France, Germany, Austria, Hungary, Italy.'},
  '1849-1': {label:'Gold Rush', cat:'economy', detail:'California Gold Rush peaks. Over 300,000 migrants flood California seeking fortune.'},
  '1853-3': {label:'Crimean War', cat:'war', detail:'Russia invades Ottoman-controlled Danubian Principalities, sparking the Crimean War.'},
  '1854-10': {label:'Light Brigade', cat:'war', detail:'The disastrous Charge of the Light Brigade at Balaclava, immortalized by Tennyson.'},
  '1859-11': {label:'Origin of Species', cat:'science', detail:'Darwin publishes On the Origin of Species, transforming biology and thought.'},
  '1861-4': {label:'Civil War begins', cat:'war', detail:'Confederate forces fire on Fort Sumter; the American Civil War begins.'},
  '1863-1': {label:'Emancipation', cat:'politics', detail:'Lincoln issues the Emancipation Proclamation, freeing enslaved people in rebel states.'},
  '1865-4': {label:'Lee surrenders', cat:'war', detail:'Lee surrenders to Grant at Appomattox. Days later Lincoln is assassinated.'},
  '1869-5': {label:'Suez Canal', cat:'economy', detail:'Suez Canal opens, connecting the Mediterranean to the Red Sea.'},
  '1871-1': {label:'German Empire', cat:'politics', detail:'German Empire proclaimed at Versailles. Bismarck becomes first Chancellor.'},
  '1876-3': {label:'Telephone', cat:'science', detail:'Alexander Graham Bell patents the telephone.'},
  '1879-10': {label:'Electric light', cat:'science', detail:'Edison demonstrates a practical incandescent light bulb.'},
  '1884-2': {label:'Berlin Conference', cat:'politics', detail:'European powers divide Africa among themselves — the Scramble for Africa.'},
  '1885-11': {label:'Automobile', cat:'science', detail:'Karl Benz patents the first true automobile, the Patent-Motorwagen.'},
  '1886-5': {label:'Haymarket', cat:'economy', detail:'Haymarket affair in Chicago — a bomb thrown at police during a labor rally.'},
  '1896-4': {label:'First Olympics', cat:'culture', detail:'First modern Olympic Games held in Athens, Greece.'},
  '1898-4': {label:'Spanish-American War', cat:'war', detail:'US declares war on Spain. Cuba, Puerto Rico, Philippines change hands.'},
  '1900-6': {label:'Boxer Rebellion', cat:'war', detail:'Boxer Rebellion in China — uprising against foreign influence and the Qing government.'},
  '1903-12': {label:'First flight', cat:'science', detail:'Wright Brothers achieve the first powered airplane flight at Kitty Hawk.'},
  '1905-10': {label:'Russian Revolution', cat:'politics', detail:'1905 Russian Revolution — Bloody Sunday massacre and widespread strikes force reforms.'},
  '1906-4': {label:'SF Earthquake', cat:'science', detail:'Great San Francisco earthquake kills ~3,000; most of the city destroyed by fire.'},
  '1908-10': {label:'Model T', cat:'economy', detail:'Ford introduces the Model T, beginning the automobile age for ordinary Americans.'},
  '1911-10': {label:'Chinese Republic', cat:'politics', detail:'Xinhai Revolution — Qing dynasty falls; Republic of China proclaimed.'},
  '1912-4': {label:'Titanic', cat:'science', detail:'RMS Titanic sinks on maiden voyage after hitting an iceberg; 1,500 die.'},
  '1914-6': {label:'Archduke killed', cat:'war', detail:'Archduke Franz Ferdinand assassinated in Sarajevo by Gavrilo Princip, triggering WWI.'},
  '1914-8': {label:'WWI begins', cat:'war', detail:'Britain declares war on Germany. The Great War engulfs Europe.'},
  '1916-7': {label:'Battle of Somme', cat:'war', detail:'First day of the Somme — 57,000 British casualties in a single day.'},
  '1917-4': {label:'US enters WWI', cat:'war', detail:'United States declares war on Germany and enters the First World War.'},
  '1917-11': {label:'Balfour Declaration', cat:'politics', detail:'Britain declares support for a Jewish homeland in Palestine.'},
  '1917-11b': {label:'Bolshevik Revolution', cat:'politics', detail:'Lenin seizes power in Russia; the Bolsheviks take control.'},
  '1918-11': {label:'WWI ends', cat:'war', detail:'Armistice signed at 11:11 on 11 November. The Great War ends after 17 million deaths.'},
  '1919-6': {label:'Treaty of Versailles', cat:'politics', detail:'Treaty of Versailles signed, formally ending WWI and imposing harsh terms on Germany.'},
  '1920-1': {label:'Prohibition', cat:'culture', detail:'18th Amendment takes effect. Prohibition begins in the United States.'},
  '1920-8': {label:'Women vote', cat:'politics', detail:'19th Amendment ratified. American women win the right to vote.'},
  '1922-10': {label:'Mussolini marches', cat:'politics', detail:"Mussolini's March on Rome. Italy's Fascist Party takes power."},
  '1923-11': {label:'Beer Hall Putsch', cat:'politics', detail:"Hitler's failed coup in Munich. He is arrested and writes Mein Kampf in prison."},
  '1927-5': {label:'Lindbergh flies', cat:'science', detail:'Charles Lindbergh completes the first solo nonstop transatlantic flight, New York to Paris.'},
  '1929-10': {label:'Wall St Crash', cat:'economy', detail:'Black Tuesday — stock market collapses, triggering the Great Depression.'},
  '1933-1': {label:'Hitler chancellor', cat:'politics', detail:'Adolf Hitler appointed Chancellor of Germany. The Third Reich begins.'},
  '1935-9': {label:'Nuremberg Laws', cat:'politics', detail:'Nazi Germany enacts the Nuremberg Laws, stripping Jews of citizenship.'},
  '1936-7': {label:'Spanish Civil War', cat:'war', detail:'Spanish Civil War begins. Franco leads a nationalist revolt against the Republican government.'},
  '1937-7': {label:'Sino-Japanese War', cat:'war', detail:'Full-scale war erupts between China and Japan after the Marco Polo Bridge Incident.'},
  '1937-12': {label:'Nanjing Massacre', cat:'war', detail:'Japanese forces capture Nanjing; hundreds of thousands of civilians killed.'},
  '1938-3': {label:'Austria annexed', cat:'politics', detail:'Anschluss — Germany annexes Austria without resistance.'},
  '1938-9': {label:'Munich Agreement', cat:'politics', detail:'Britain and France allow Germany to annex the Sudetenland. Peace for our time.'},
  '1939-9': {label:'WWII begins', cat:'war', detail:'Germany invades Poland. Britain and France declare war. World War II begins.'},
  '1940-5': {label:'Dunkirk', cat:'war', detail:'Dunkirk evacuation — 338,000 Allied troops rescued from the beaches of France.'},
  '1940-7': {label:'Battle of Britain', cat:'war', detail:'Luftwaffe begins sustained bombing of Britain. RAF fights back in the skies.'},
  '1941-6': {label:'Operation Barbarossa', cat:'war', detail:'Germany invades the Soviet Union with 3 million troops.'},
  '1941-12': {label:'Pearl Harbor', cat:'war', detail:'Japan attacks Pearl Harbor. United States enters World War II.'},
  '1942-6': {label:'Midway', cat:'war', detail:'Battle of Midway — decisive US naval victory; turns the tide of the Pacific War.'},
  '1942-8': {label:'Stalingrad', cat:'war', detail:'Battle of Stalingrad begins — the bloodiest battle in history; over 2 million casualties.'},
  '1944-6': {label:'D-Day', cat:'war', detail:'D-Day landings at Normandy — the liberation of Europe begins.'},
  '1945-5': {label:'VE Day', cat:'war', detail:'Victory in Europe. Germany surrenders unconditionally. Hitler dead by suicide.'},
  '1945-8': {label:'Atomic bombs', cat:'war', detail:'US drops atomic bombs on Hiroshima and Nagasaki. ~200,000 dead.'},
  '1945-9': {label:'VJ Day', cat:'war', detail:'Japan formally surrenders. World War II ends after ~70-85 million deaths.'},
  '1947-8': {label:'India independence', cat:'politics', detail:'India and Pakistan gain independence from Britain. Partition displaces 15 million people.'},
  '1948-5': {label:'Israel founded', cat:'politics', detail:'State of Israel declared. Immediately invaded by neighboring Arab states.'},
  '1949-10': {label:"People's Republic", cat:'politics', detail:"Mao Zedong proclaims the People's Republic of China."},
  '1950-6': {label:'Korean War', cat:'war', detail:'North Korea invades South Korea. US and UN forces intervene.'},
  '1953-3': {label:'Stalin dies', cat:'politics', detail:'Joseph Stalin dies. Power struggle ensues in the USSR.'},
  '1953-7': {label:'Korean armistice', cat:'war', detail:'Korean War armistice signed. The peninsula remains divided at the 38th parallel.'},
  '1954-5': {label:'Dien Bien Phu', cat:'war', detail:'France defeated at Dien Bien Phu. Vietnam divided; US begins filling the vacuum.'},
  '1955-12': {label:'Bus Boycott', cat:'culture', detail:'Rosa Parks arrested; Montgomery Bus Boycott begins. MLK emerges as a leader.'},
  '1957-10': {label:'Sputnik', cat:'science', detail:'USSR launches Sputnik, the first artificial satellite. The Space Race begins.'},
  '1959-1': {label:'Cuban Revolution', cat:'politics', detail:"Castro's forces take Havana. Cuba becomes a communist state."}
}

var WAR_ERA_SET = {}
var y, m
for (y = 1914; y <= 1918; y++) for (m = 0; m < 12; m++) WAR_ERA_SET[y+'-'+m] = true
for (y = 1939; y <= 1945; y++) for (m = 0; m < 12; m++) WAR_ERA_SET[y+'-'+m] = true

var CAT_BG = {war:'#6b3a3a', politics:'#2a4a6b', science:'#2d5a3d', culture:'#5a3a6b', economy:'#6b5a2a'}
var CAT_DOT = {war:'#e07070', politics:'#6aa0e0', science:'#6acea0', culture:'#b080d0', economy:'#d0b060'}

function getCellEvents(year, month) {
  var results = []
  var prefix = year + '-' + (month + 1)
  Object.keys(EVENTS).forEach(function(k) {
    var parts = k.replace(/[a-z]+$/, '').split('-')
    if (parseInt(parts[0]) === year && parseInt(parts[1]) === (month + 1)) {
      results.push(EVENTS[k])
    }
  })
  return results
}

function buildTable() {
  var thead = document.querySelector('#tl-table thead')
  var tbody = document.querySelector('#tl-table tbody')

  var hdrRow = document.createElement('tr')
  var corner = document.createElement('th')
  corner.className = 'row-hdr'
  corner.textContent = 'Year'
  hdrRow.appendChild(corner)
  MONTHS.forEach(function(mn) {
    var th = document.createElement('th')
    th.textContent = mn
    th.style.width = '52px'
    th.style.minWidth = '52px'
    hdrRow.appendChild(th)
  })
  thead.appendChild(hdrRow)

  for (var yr = START_YEAR; yr <= END_YEAR; yr++) {
    var tr = document.createElement('tr')
    var rh = document.createElement('td')
    rh.className = 'row-hdr'
    rh.textContent = yr
    tr.appendChild(rh)

    for (var mo = 0; mo < 12; mo++) {
      var td = document.createElement('td')
      td.className = 'tl-cell'
      td.dataset.year = yr
      td.dataset.month = mo

      var warEra = WAR_ERA_SET[yr + '-' + mo]
      var evts = getCellEvents(yr, mo)

      if (warEra) {
        td.style.background = '#1a1010'
      }
      if (evts.length > 0) {
        if (!warEra) td.style.background = CAT_BG[evts[0].cat] || '#333'
        var dw = document.createElement('div')
        dw.className = 'dot-wrap'
        evts.slice(0, 3).forEach(function(ev) {
          var dot = document.createElement('div')
          dot.className = 'tl-dot'
          dot.style.background = CAT_DOT[ev.cat] || '#aaa'
          dw.appendChild(dot)
        })
        td.appendChild(dw)
        var lbl = document.createElement('div')
        lbl.className = 'cell-label'
        lbl.textContent = evts[0].label
        td.appendChild(lbl)
      }

      td.addEventListener('click', handleCellClick)
      tr.appendChild(td)
    }
    tbody.appendChild(tr)
  }
}

function handleCellClick(e) {
  var td = e.currentTarget
  var year = parseInt(td.dataset.year)
  var month = parseInt(td.dataset.month)
  var evts = getCellEvents(year, month)
  var detail = document.getElementById('tl-detail')
  var mn = MONTHS[month]

  document.querySelectorAll('.tl-cell.sel').forEach(function(c) { c.classList.remove('sel') })
  td.classList.add('sel')
  td.style.outline = '2px solid white'

  if (evts.length === 0) {
    detail.innerHTML = '<span style="color:var(--color-text-tertiary)">' + mn + ' ' + year + ' — no events recorded. </span>' +
      '<button class="tl-btn" style="font-size:12px;padding:2px 8px" onclick="sendPrompt(\'What was happening in the world in ' + mn + ' ' + year + '?\')">Ask Claude \u2197</button>'
  } else {
    var badges = evts.map(function(ev) {
      return '<span style="display:inline-block;margin-right:4px;padding:1px 6px;border-radius:4px;font-size:11px;background:' + CAT_BG[ev.cat] + ';color:#ddd">' + ev.label + '</span>'
    }).join('')
    var details = evts.map(function(ev) { return ev.detail }).join(' &bull; ')
    detail.innerHTML = '<strong style="color:var(--color-text-primary)">' + mn + ' ' + year + '</strong> &nbsp;' + badges +
      '<br><span style="color:var(--color-text-secondary)">' + details + '</span>' +
      ' &nbsp;<button class="tl-btn" style="font-size:12px;padding:2px 8px;margin-top:4px" onclick="sendPrompt(\'Tell me more about what was happening in ' + mn + ' ' + year + '\')">Explore this period \u2197</button>'
  }
}

var scale = 1
document.getElementById('btn-zoom-in').addEventListener('click', function() {
  scale = Math.min(3, scale * 1.25)
  document.getElementById('tl-table').style.transform = 'scale(' + scale + ')'
  document.getElementById('tl-table').style.transformOrigin = 'top left'
})
document.getElementById('btn-zoom-out').addEventListener('click', function() {
  scale = Math.max(0.35, scale / 1.25)
  document.getElementById('tl-table').style.transform = 'scale(' + scale + ')'
  document.getElementById('tl-table').style.transformOrigin = 'top left'
})
document.getElementById('btn-reset').addEventListener('click', function() {
  scale = 1
  document.getElementById('tl-table').style.transform = ''
  document.getElementById('tl-scroll').scrollTop = 0
  document.getElementById('tl-scroll').scrollLeft = 0
})

document.getElementById('tl-scroll').addEventListener('wheel', function(e) {
  if (e.ctrlKey || e.metaKey) {
    e.preventDefault()
    scale = Math.max(0.35, Math.min(3, scale * (e.deltaY > 0 ? 0.9 : 1.1)))
    document.getElementById('tl-table').style.transform = 'scale(' + scale + ')'
    document.getElementById('tl-table').style.transformOrigin = 'top left'
  }
}, {passive: false})

buildTable()

setTimeout(function() {
  var row = document.querySelector('[data-year="1914"]')
  if (row) row.scrollIntoView({behavior: 'smooth', block: 'center'})
}, 400)
</script>
