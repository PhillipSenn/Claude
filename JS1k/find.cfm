<cfscript>
include '/Inc/header.cfm'
</cfscript>
I never ran this. 
Claude said 
you just need Node.js installed — open a terminal in the same folder and run node find-js1k-original-source.js.

<script>
// find-js1k-original-source.js
// Finds all js1k entries that include an "Original source" section in their details page.
// Run with: node find-js1k-original-source.js

var https = require('https')

var YEARS = [
  { slug: '2010-first',     base: 'https://js1k.com/2010-first' },
  { slug: '2010-xmas',      base: 'https://js1k.com/2010-xmas' },
  { slug: '2011-trail',     base: 'https://js1k.com/2011-trail' },
  { slug: '2012-love',      base: 'https://js1k.com/2012-love' },
  { slug: '2013-spring',    base: 'https://js1k.com/2013-spring' },
  { slug: '2014-dragons',   base: 'https://js1k.com/2014-dragons' },
  { slug: '2015-hypetrain', base: 'https://js1k.com/2015-hypetrain' },
  { slug: '2016-elemental', base: 'https://js1k.com/2016-elemental' },
  { slug: '2017-magic',     base: 'https://js1k.com/2017-magic' },
  { slug: '2018-coins',     base: 'https://js1k.com/2018-coins' },
  { slug: '2019-x',         base: 'https://js1k.com/2019-x' }
]

var CONCURRENCY = 8
var results = []
var errors = []

function get(url) {
  return new Promise(function(resolve, reject) {
    var req = https.get(url, { timeout: 15000 }, function(res) {
      // follow redirects
      if (res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
        return get(res.headers.location).then(resolve, reject)
      }
      var chunks = []
      res.on('data', function(c) { chunks.push(c) })
      res.on('end', function() { resolve(Buffer.concat(chunks).toString()) })
      res.on('error', reject)
    })
    req.on('error', reject)
    req.on('timeout', function() { req.destroy(new Error('timeout')) })
  })
}

function extractIds(html, slug) {
  var ids = []
  var re = /details\/(\d+)/g
  var seen = {}
  var m
  while ((m = re.exec(html)) !== null) {
    var id = m[1]
    if (!seen[id]) {
      seen[id] = true
      ids.push(id)
    }
  }
  return ids
}

function checkDetails(year, id) {
  var url = year.base + '/details/' + id
  return get(url).then(function(html) {
    if (html.indexOf('Original source') !== -1) {
      // extract title
      var titleMatch = html.match(/## (.+)\n/)
      var title = titleMatch ? titleMatch[1].trim() : '(unknown)'
      results.push({ id: id, year: year.slug, title: title, url: 'https://js1k.com/' + id })
      process.stdout.write('✓ ' + id + ' (' + year.slug + ') - ' + title + '\n')
    }
  }).catch(function(e) {
    errors.push({ id: id, year: year.slug, error: e.message })
  })
}

function runWithConcurrency(tasks, limit) {
  var index = 0
  var active = 0
  return new Promise(function(resolve) {
    function next() {
      while (active < limit && index < tasks.length) {
        active++
        var task = tasks[index++]
        task().then(function() {
          active--
          if (index >= tasks.length && active === 0) resolve()
          else next()
        })
      }
    }
    next()
    if (tasks.length === 0) resolve()
  })
}

async function main() {
  console.log('Fetching demo lists for all years...\n')

  var allTasks = []

  for (var i = 0; i < YEARS.length; i++) {
    var year = YEARS[i]
    process.stdout.write('  ' + year.slug + '... ')
    var html
    try {
      html = await get(year.base + '/demos')
    } catch(e) {
      try {
        html = await get(year.base + '/demos/')
      } catch(e2) {
        console.log('FAILED: ' + e2.message)
        continue
      }
    }
    var ids = extractIds(html, year.slug)
    console.log(ids.length + ' entries')
    for (var j = 0; j < ids.length; j++) {
      var capturedYear = year
      var capturedId = ids[j]
      allTasks.push((function(y, id) {
        return function() { return checkDetails(y, id) }
      })(capturedYear, capturedId))
    }
  }

  console.log('\nChecking ' + allTasks.length + ' details pages with concurrency=' + CONCURRENCY + '...\n')

  await runWithConcurrency(allTasks, CONCURRENCY)

  // sort results by id
  results.sort(function(a, b) { return parseInt(a.id) - parseInt(b.id) })

  console.log('\n\n=== ENTRIES WITH ORIGINAL SOURCE (' + results.length + ' found) ===\n')
  for (var k = 0; k < results.length; k++) {
    var r = results[k]
    console.log('[' + r.id + '] ' + r.title + ' (' + r.year + ')')
    console.log('  ' + r.url)
    console.log('  details: ' + r.url.replace('js1k.com/', 'js1k.com/' + r.year + '/details/').replace('https://js1k.com/' + r.year + '/details/' + r.id, 'https://js1k.com/' + r.year + '/details/' + r.id))
  }

  if (errors.length > 0) {
    console.log('\n' + errors.length + ' errors (retry these manually):')
    for (var l = 0; l < errors.length; l++) {
      console.log('  ' + errors[l].id + ' (' + errors[l].year + '): ' + errors[l].error)
    }
  }
}

main().catch(function(e) { console.error(e) })
</script>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>