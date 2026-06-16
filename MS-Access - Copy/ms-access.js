app.version = 3
document.getElementById('app-version').textContent = 'v' + app.version

$(document).ready(init)

function init() {
	var tables        = readTables()
	var relationships = readRelationships()
	renderTables(tables)
	drawRelationships(relationships)
}

function readTables() {
	var tables       = []
	var currentName  = ''
	var currentTable = null

	$('#tableData tbody tr').each(each_tableDataRow)

	function each_tableDataRow() {
		var tds       = $(this).find('td')
		var tableName = tds.eq(0).text()
		var colName   = tds.eq(1).text()
		var isPK      = tds.eq(2).text() === '1'

		if (tableName !== currentName) {
			if (currentTable) tables.push(currentTable)
			currentName  = tableName
			currentTable = { name: tableName, columns: [] }
		}
		currentTable.columns.push({ name: colName, isPK: isPK })
	}

	if (currentTable) tables.push(currentTable)
	return tables
}

function readRelationships() {
	var relationships = []

	$('#tableRelationships tbody tr').each(each_relRow)

	function each_relRow() {
		var tds = $(this).find('td')
		relationships.push({
			fk_table:  tds.eq(0).text(),
			fk_column: tds.eq(1).text(),
			pk_table:  tds.eq(2).text(),
			pk_column: tds.eq(3).text()
		})
	}

	return relationships
}

function renderTables(tables) {
	var grid = document.getElementById('table-grid')
	tables.forEach(each_table)

	function each_table(table) {
		var box = document.createElement('div')
		box.className = 'table-box'
		box.id        = 'table-' + table.name

		var header = document.createElement('div')
		header.className   = 'table-header'
		header.textContent = table.name
		box.appendChild(header)

		for (var i = 0; i < table.columns.length; i++) {
			renderColumn(table.columns[i], table.name, box)
		}

		grid.appendChild(box)
	}
}

function renderColumn(col, tableName, box) {
	var row = document.createElement('div')
	row.className   = 'col-row' + (col.isPK ? ' pk-col' : '')
	row.id          = 'col-' + tableName + '-' + col.name
	row.textContent = col.name
	box.appendChild(row)
}

function getPositionInDiagram(el) {
	var diagram     = document.getElementById('diagram')
	var elRect      = el.getBoundingClientRect()
	var diagramRect = diagram.getBoundingClientRect()
	return {
		top:    elRect.top    - diagramRect.top,
		left:   elRect.left   - diagramRect.left,
		right:  elRect.right  - diagramRect.left,
		bottom: elRect.bottom - diagramRect.top,
		width:  elRect.width,
		height: elRect.height
	}
}

function drawRelationships(relationships) {
	var diagram = document.getElementById('diagram')
	var svg     = document.getElementById('lines-svg')
	svg.setAttribute('width',  diagram.offsetWidth)
	svg.setAttribute('height', diagram.offsetHeight)

	relationships.forEach(each_relationship)

	function each_relationship(rel) {
		var fkEl = document.getElementById('col-' + rel.fk_table + '-' + rel.fk_column)
		var pkEl = document.getElementById('col-' + rel.pk_table + '-' + rel.pk_column)
		if (!fkEl || !pkEl) return

		var fkPos = getPositionInDiagram(fkEl)
		var pkPos = getPositionInDiagram(pkEl)

		var fkCenterX = fkPos.left + fkPos.width / 2
		var pkCenterX = pkPos.left + pkPos.width / 2

		var x1, x2
		if (fkCenterX < pkCenterX) {
			x1 = fkPos.right
			x2 = pkPos.left
		} else {
			x1 = fkPos.left
			x2 = pkPos.right
		}

		var y1  = fkPos.top + fkPos.height / 2
		var y2  = pkPos.top + pkPos.height / 2
		var dx  = Math.abs(x2 - x1) * 0.5
		var cx1 = x1 < x2 ? x1 + dx : x1 - dx
		var cx2 = x1 < x2 ? x2 - dx : x2 + dx

		var path = document.createElementNS('http://www.w3.org/2000/svg', 'path')
		var d    = 'M ' + x1  + ',' + y1
		        + ' C ' + cx1 + ',' + y1
		        + ' '   + cx2 + ',' + y2
		        + ' '   + x2  + ',' + y2
		path.setAttribute('d',            d)
		path.setAttribute('stroke',       '#337ab7')
		path.setAttribute('stroke-width', '2')
		path.setAttribute('fill',         'none')
		svg.appendChild(path)
	}
}
