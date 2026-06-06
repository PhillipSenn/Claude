// "You're waiting for a train. A train that will take you far away." — Inception
var app = {}
app.version = 5

document.getElementById('app-version').innerHTML = '&bull; v' + app.version

var categories = {
  'alkali-metal':    { label: 'Alkali Metal',         color: '#ff6b6b' },
  'alkaline-earth':  { label: 'Alkaline Earth Metal', color: '#ffa94d' },
  'transition':      { label: 'Transition Metal',      color: '#74c0fc' },
  'post-transition': { label: 'Post-transition Metal', color: '#a9e34b' },
  'metalloid':       { label: 'Metalloid',             color: '#63e6be' },
  'nonmetal':        { label: 'Nonmetal',              color: '#8ce99a' },
  'halogen':         { label: 'Halogen',               color: '#ffec99' },
  'noble-gas':       { label: 'Noble Gas',             color: '#d0bfff' },
  'lanthanide':      { label: 'Lanthanide',            color: '#ffa8d4' },
  'actinide':        { label: 'Actinide',              color: '#ff8787' }
}

// row = grid row (1-7 main, 9 lanthanides, 10 actinides), col = grid column (1-18)
var elements = [
  // Period 1
  { z:1,   sym:'H',  name:'Hydrogen',      row:1, col:1,  cat:'nonmetal' },
  { z:2,   sym:'He', name:'Helium',        row:1, col:18, cat:'noble-gas' },
  // Period 2
  { z:3,   sym:'Li', name:'Lithium',       row:2, col:1,  cat:'alkali-metal' },
  { z:4,   sym:'Be', name:'Beryllium',     row:2, col:2,  cat:'alkaline-earth' },
  { z:5,   sym:'B',  name:'Boron',         row:2, col:13, cat:'metalloid' },
  { z:6,   sym:'C',  name:'Carbon',        row:2, col:14, cat:'nonmetal' },
  { z:7,   sym:'N',  name:'Nitrogen',      row:2, col:15, cat:'nonmetal' },
  { z:8,   sym:'O',  name:'Oxygen',        row:2, col:16, cat:'nonmetal' },
  { z:9,   sym:'F',  name:'Fluorine',      row:2, col:17, cat:'halogen' },
  { z:10,  sym:'Ne', name:'Neon',          row:2, col:18, cat:'noble-gas' },
  // Period 3
  { z:11,  sym:'Na', name:'Sodium',        row:3, col:1,  cat:'alkali-metal' },
  { z:12,  sym:'Mg', name:'Magnesium',     row:3, col:2,  cat:'alkaline-earth' },
  { z:13,  sym:'Al', name:'Aluminum',      row:3, col:13, cat:'post-transition' },
  { z:14,  sym:'Si', name:'Silicon',       row:3, col:14, cat:'metalloid' },
  { z:15,  sym:'P',  name:'Phosphorus',    row:3, col:15, cat:'nonmetal' },
  { z:16,  sym:'S',  name:'Sulfur',        row:3, col:16, cat:'nonmetal' },
  { z:17,  sym:'Cl', name:'Chlorine',      row:3, col:17, cat:'halogen' },
  { z:18,  sym:'Ar', name:'Argon',         row:3, col:18, cat:'noble-gas' },
  // Period 4
  { z:19,  sym:'K',  name:'Potassium',     row:4, col:1,  cat:'alkali-metal' },
  { z:20,  sym:'Ca', name:'Calcium',       row:4, col:2,  cat:'alkaline-earth' },
  { z:21,  sym:'Sc', name:'Scandium',      row:4, col:3,  cat:'transition' },
  { z:22,  sym:'Ti', name:'Titanium',      row:4, col:4,  cat:'transition' },
  { z:23,  sym:'V',  name:'Vanadium',      row:4, col:5,  cat:'transition' },
  { z:24,  sym:'Cr', name:'Chromium',      row:4, col:6,  cat:'transition' },
  { z:25,  sym:'Mn', name:'Manganese',     row:4, col:7,  cat:'transition' },
  { z:26,  sym:'Fe', name:'Iron',          row:4, col:8,  cat:'transition' },
  { z:27,  sym:'Co', name:'Cobalt',        row:4, col:9,  cat:'transition' },
  { z:28,  sym:'Ni', name:'Nickel',        row:4, col:10, cat:'transition' },
  { z:29,  sym:'Cu', name:'Copper',        row:4, col:11, cat:'transition' },
  { z:30,  sym:'Zn', name:'Zinc',          row:4, col:12, cat:'transition' },
  { z:31,  sym:'Ga', name:'Gallium',       row:4, col:13, cat:'post-transition' },
  { z:32,  sym:'Ge', name:'Germanium',     row:4, col:14, cat:'metalloid' },
  { z:33,  sym:'As', name:'Arsenic',       row:4, col:15, cat:'metalloid' },
  { z:34,  sym:'Se', name:'Selenium',      row:4, col:16, cat:'nonmetal' },
  { z:35,  sym:'Br', name:'Bromine',       row:4, col:17, cat:'halogen' },
  { z:36,  sym:'Kr', name:'Krypton',       row:4, col:18, cat:'noble-gas' },
  // Period 5
  { z:37,  sym:'Rb', name:'Rubidium',      row:5, col:1,  cat:'alkali-metal' },
  { z:38,  sym:'Sr', name:'Strontium',     row:5, col:2,  cat:'alkaline-earth' },
  { z:39,  sym:'Y',  name:'Yttrium',       row:5, col:3,  cat:'transition' },
  { z:40,  sym:'Zr', name:'Zirconium',     row:5, col:4,  cat:'transition' },
  { z:41,  sym:'Nb', name:'Niobium',       row:5, col:5,  cat:'transition' },
  { z:42,  sym:'Mo', name:'Molybdenum',    row:5, col:6,  cat:'transition' },
  { z:43,  sym:'Tc', name:'Technetium',    row:5, col:7,  cat:'transition' },
  { z:44,  sym:'Ru', name:'Ruthenium',     row:5, col:8,  cat:'transition' },
  { z:45,  sym:'Rh', name:'Rhodium',       row:5, col:9,  cat:'transition' },
  { z:46,  sym:'Pd', name:'Palladium',     row:5, col:10, cat:'transition' },
  { z:47,  sym:'Ag', name:'Silver',        row:5, col:11, cat:'transition' },
  { z:48,  sym:'Cd', name:'Cadmium',       row:5, col:12, cat:'transition' },
  { z:49,  sym:'In', name:'Indium',        row:5, col:13, cat:'post-transition' },
  { z:50,  sym:'Sn', name:'Tin',           row:5, col:14, cat:'post-transition' },
  { z:51,  sym:'Sb', name:'Antimony',      row:5, col:15, cat:'metalloid' },
  { z:52,  sym:'Te', name:'Tellurium',     row:5, col:16, cat:'metalloid' },
  { z:53,  sym:'I',  name:'Iodine',        row:5, col:17, cat:'halogen' },
  { z:54,  sym:'Xe', name:'Xenon',         row:5, col:18, cat:'noble-gas' },
  // Period 6  (col 3 = lanthanide placeholder, added separately)
  { z:55,  sym:'Cs', name:'Cesium',        row:6, col:1,  cat:'alkali-metal' },
  { z:56,  sym:'Ba', name:'Barium',        row:6, col:2,  cat:'alkaline-earth' },
  { z:72,  sym:'Hf', name:'Hafnium',       row:6, col:4,  cat:'transition' },
  { z:73,  sym:'Ta', name:'Tantalum',      row:6, col:5,  cat:'transition' },
  { z:74,  sym:'W',  name:'Tungsten',      row:6, col:6,  cat:'transition' },
  { z:75,  sym:'Re', name:'Rhenium',       row:6, col:7,  cat:'transition' },
  { z:76,  sym:'Os', name:'Osmium',        row:6, col:8,  cat:'transition' },
  { z:77,  sym:'Ir', name:'Iridium',       row:6, col:9,  cat:'transition' },
  { z:78,  sym:'Pt', name:'Platinum',      row:6, col:10, cat:'transition' },
  { z:79,  sym:'Au', name:'Gold',          row:6, col:11, cat:'transition' },
  { z:80,  sym:'Hg', name:'Mercury',       row:6, col:12, cat:'transition' },
  { z:81,  sym:'Tl', name:'Thallium',      row:6, col:13, cat:'post-transition' },
  { z:82,  sym:'Pb', name:'Lead',          row:6, col:14, cat:'post-transition' },
  { z:83,  sym:'Bi', name:'Bismuth',       row:6, col:15, cat:'post-transition' },
  { z:84,  sym:'Po', name:'Polonium',      row:6, col:16, cat:'metalloid' },
  { z:85,  sym:'At', name:'Astatine',      row:6, col:17, cat:'halogen' },
  { z:86,  sym:'Rn', name:'Radon',         row:6, col:18, cat:'noble-gas' },
  // Period 7  (col 3 = actinide placeholder, added separately)
  { z:87,  sym:'Fr', name:'Francium',      row:7, col:1,  cat:'alkali-metal' },
  { z:88,  sym:'Ra', name:'Radium',        row:7, col:2,  cat:'alkaline-earth' },
  { z:104, sym:'Rf', name:'Rutherfordium', row:7, col:4,  cat:'transition' },
  { z:105, sym:'Db', name:'Dubnium',       row:7, col:5,  cat:'transition' },
  { z:106, sym:'Sg', name:'Seaborgium',    row:7, col:6,  cat:'transition' },
  { z:107, sym:'Bh', name:'Bohrium',       row:7, col:7,  cat:'transition' },
  { z:108, sym:'Hs', name:'Hassium',       row:7, col:8,  cat:'transition' },
  { z:109, sym:'Mt', name:'Meitnerium',    row:7, col:9,  cat:'transition' },
  { z:110, sym:'Ds', name:'Darmstadtium',  row:7, col:10, cat:'transition' },
  { z:111, sym:'Rg', name:'Roentgenium',   row:7, col:11, cat:'transition' },
  { z:112, sym:'Cn', name:'Copernicium',   row:7, col:12, cat:'transition' },
  { z:113, sym:'Nh', name:'Nihonium',      row:7, col:13, cat:'post-transition' },
  { z:114, sym:'Fl', name:'Flerovium',     row:7, col:14, cat:'post-transition' },
  { z:115, sym:'Mc', name:'Moscovium',     row:7, col:15, cat:'post-transition' },
  { z:116, sym:'Lv', name:'Livermorium',   row:7, col:16, cat:'post-transition' },
  { z:117, sym:'Ts', name:'Tennessine',    row:7, col:17, cat:'halogen' },
  { z:118, sym:'Og', name:'Oganesson',     row:7, col:18, cat:'noble-gas' },
  // Lanthanides — row 9 in the grid
  { z:57,  sym:'La', name:'Lanthanum',     row:9, col:3,  cat:'lanthanide' },
  { z:58,  sym:'Ce', name:'Cerium',        row:9, col:4,  cat:'lanthanide' },
  { z:59,  sym:'Pr', name:'Praseodymium',  row:9, col:5,  cat:'lanthanide' },
  { z:60,  sym:'Nd', name:'Neodymium',     row:9, col:6,  cat:'lanthanide' },
  { z:61,  sym:'Pm', name:'Promethium',    row:9, col:7,  cat:'lanthanide' },
  { z:62,  sym:'Sm', name:'Samarium',      row:9, col:8,  cat:'lanthanide' },
  { z:63,  sym:'Eu', name:'Europium',      row:9, col:9,  cat:'lanthanide' },
  { z:64,  sym:'Gd', name:'Gadolinium',    row:9, col:10, cat:'lanthanide' },
  { z:65,  sym:'Tb', name:'Terbium',       row:9, col:11, cat:'lanthanide' },
  { z:66,  sym:'Dy', name:'Dysprosium',    row:9, col:12, cat:'lanthanide' },
  { z:67,  sym:'Ho', name:'Holmium',       row:9, col:13, cat:'lanthanide' },
  { z:68,  sym:'Er', name:'Erbium',        row:9, col:14, cat:'lanthanide' },
  { z:69,  sym:'Tm', name:'Thulium',       row:9, col:15, cat:'lanthanide' },
  { z:70,  sym:'Yb', name:'Ytterbium',     row:9, col:16, cat:'lanthanide' },
  { z:71,  sym:'Lu', name:'Lutetium',      row:9, col:17, cat:'lanthanide' },
  // Actinides — row 10 in the grid
  { z:89,  sym:'Ac', name:'Actinium',      row:10, col:3,  cat:'actinide' },
  { z:90,  sym:'Th', name:'Thorium',       row:10, col:4,  cat:'actinide' },
  { z:91,  sym:'Pa', name:'Protactinium',  row:10, col:5,  cat:'actinide' },
  { z:92,  sym:'U',  name:'Uranium',       row:10, col:6,  cat:'actinide' },
  { z:93,  sym:'Np', name:'Neptunium',     row:10, col:7,  cat:'actinide' },
  { z:94,  sym:'Pu', name:'Plutonium',     row:10, col:8,  cat:'actinide' },
  { z:95,  sym:'Am', name:'Americium',     row:10, col:9,  cat:'actinide' },
  { z:96,  sym:'Cm', name:'Curium',        row:10, col:10, cat:'actinide' },
  { z:97,  sym:'Bk', name:'Berkelium',     row:10, col:11, cat:'actinide' },
  { z:98,  sym:'Cf', name:'Californium',   row:10, col:12, cat:'actinide' },
  { z:99,  sym:'Es', name:'Einsteinium',   row:10, col:13, cat:'actinide' },
  { z:100, sym:'Fm', name:'Fermium',       row:10, col:14, cat:'actinide' },
  { z:101, sym:'Md', name:'Mendelevium',   row:10, col:15, cat:'actinide' },
  { z:102, sym:'No', name:'Nobelium',      row:10, col:16, cat:'actinide' },
  { z:103, sym:'Lr', name:'Lawrencium',    row:10, col:17, cat:'actinide' }
]

function buildTable() {
  var $table = $('#periodic-table')

  // Lanthanide placeholder at row 6 col 3
  var $la = $('<div>')
    .addClass('element placeholder')
    .attr('data-cat', 'lanthanide')
    .css({
      'grid-row': 6,
      'grid-column': 3,
      'background-color': categories['lanthanide'].color
    })
    .html(
      '<div class="elem-num">57&#8211;71</div>' +
      '<div class="elem-sym">*</div>' +
      '<div class="elem-name">Lanthanides</div>'
    )
  $table.append($la)

  // Actinide placeholder at row 7 col 3
  var $ac = $('<div>')
    .addClass('element placeholder')
    .attr('data-cat', 'actinide')
    .css({
      'grid-row': 7,
      'grid-column': 3,
      'background-color': categories['actinide'].color
    })
    .html(
      '<div class="elem-num">89&#8211;103</div>' +
      '<div class="elem-sym">**</div>' +
      '<div class="elem-name">Actinides</div>'
    )
  $table.append($ac)

  $.each(elements, each_element)
}

function each_element(i, el) {
  var color = categories[el.cat] ? categories[el.cat].color : '#ccc'
  var $cell = $('<div>')
    .addClass('element')
    .attr('data-cat', el.cat)
    .css({
      'grid-row': el.row,
      'grid-column': el.col,
      'background-color': color
    })
    .html(
      '<div class="elem-num">' + el.z + '</div>' +
      '<div class="elem-sym">' + el.sym + '</div>' +
      '<div class="elem-name">' + el.name + '</div>'
    )
  $('#periodic-table').append($cell)
}

function buildLegend() {
  var $legend = $('#legend')
  $.each(categories, each_category)
}

function each_category(key, cat) {
  var $item = $('<div>')
    .addClass('legend-item')
    .attr('data-cat', key)
    .html(
      '<div class="legend-swatch" style="background-color:' + cat.color + '"></div>' +
      '<span>' + cat.label + '</span>'
    )
  $('#legend').append($item)
}

var discovered = {}
var totalCategories = Object.keys(categories).length
var pointsEach = Math.floor(100 / totalCategories)

function highlightCategory(cat) {
  $('.element').addClass('dimmed')
  $('.element[data-cat="' + cat + '"]').removeClass('dimmed').addClass('highlighted')
  $('.legend-item').addClass('dimmed')
  $('.legend-item[data-cat="' + cat + '"]').removeClass('dimmed').addClass('highlighted')
}

function clearHighlights() {
  $('.element').removeClass('dimmed highlighted')
  $('.legend-item').removeClass('dimmed highlighted')
}

function discoverCategory(cat) {
  if (discovered[cat]) return
  discovered[cat] = true
  var count = Object.keys(discovered).length
  var pct = count === totalCategories ? 100 : count * pointsEach
  var $bar = $('#discovery-bar')
  $bar.css('width', pct + '%').attr('aria-valuenow', pct).text(pct + '%')
  if (pct === 100) {
    $bar.removeClass('progress-bar-striped progress-bar-animated').addClass('bg-success')
    $('#progress-label').text('You discovered all ' + totalCategories + ' categories!')
  } else {
    var remaining = totalCategories - count
    $('#progress-label').text(count + ' of ' + totalCategories + ' categories discovered — ' + remaining + ' to go')
  }
}

$(document).on('mouseenter', '.element', element_mouseenter)
$(document).on('mouseleave', '.element', element_mouseleave)
$(document).on('mouseenter', '.legend-item', legend_mouseenter)
$(document).on('mouseleave', '.legend-item', legend_mouseleave)

function element_mouseenter() {
  var cat = $(this).data('cat')
  highlightCategory(cat)
  discoverCategory(cat)
}

function element_mouseleave() {
  clearHighlights()
}

function legend_mouseenter() {
  var cat = $(this).data('cat')
  highlightCategory(cat)
  discoverCategory(cat)
}

function legend_mouseleave() {
  clearHighlights()
}

$(function() {
  buildTable()
  buildLegend()
})
