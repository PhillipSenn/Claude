<!--- relationships.cfm --->
<!--- "I'll be back." — The Terminator --->
<cfinclude template="/Inc/header.cfm">

<cfquery name="qColumns" datasource="CommunityBookmarking">
	SELECT
		t.TABLE_NAME,
		c.COLUMN_NAME,
		c.ORDINAL_POSITION,
		CASE WHEN kcu.COLUMN_NAME IS NOT NULL THEN 1 ELSE 0 END AS IS_PK
	FROM INFORMATION_SCHEMA.TABLES t
	INNER JOIN INFORMATION_SCHEMA.COLUMNS c
		ON  t.TABLE_NAME   = c.TABLE_NAME
		AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
	LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
		ON  t.TABLE_NAME   = tc.TABLE_NAME
		AND t.TABLE_SCHEMA = tc.TABLE_SCHEMA
		AND tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
	LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
		ON  tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
		AND c.COLUMN_NAME      = kcu.COLUMN_NAME
		AND kcu.TABLE_SCHEMA   = c.TABLE_SCHEMA
	WHERE t.TABLE_TYPE   = 'BASE TABLE'
		AND t.TABLE_SCHEMA = 'dbo'
	ORDER BY t.TABLE_NAME, c.ORDINAL_POSITION
</cfquery>

<cfquery name="qFK" datasource="CommunityBookmarking">
	SELECT
		fk_tc.TABLE_NAME   AS FK_TABLE,
		fk_kcu.COLUMN_NAME AS FK_COLUMN,
		pk_tc.TABLE_NAME   AS PK_TABLE,
		pk_kcu.COLUMN_NAME AS PK_COLUMN
	FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
	INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS fk_tc
		ON rc.CONSTRAINT_NAME = fk_tc.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE fk_kcu
		ON rc.CONSTRAINT_NAME = fk_kcu.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS pk_tc
		ON rc.UNIQUE_CONSTRAINT_NAME = pk_tc.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE pk_kcu
		ON rc.UNIQUE_CONSTRAINT_NAME = pk_kcu.CONSTRAINT_NAME
	ORDER BY fk_tc.TABLE_NAME, fk_kcu.COLUMN_NAME
</cfquery>

<!--- Build table data --->
<cfset tableData = []>
<cfset prevTable = "">
<cfset tableObj  = {}>

<cfloop query="qColumns">
	<cfif TABLE_NAME NEQ prevTable>
		<cfif prevTable NEQ "">
			<cfset ArrayAppend(tableData, tableObj)>
		</cfif>
		<cfset prevTable = TABLE_NAME>
		<cfset tableObj = StructNew()>
		<cfset tableObj["name"]    = TABLE_NAME>
		<cfset tableObj["columns"] = []>
	</cfif>
	<cfset col = StructNew()>
	<cfset col["name"] = COLUMN_NAME>
	<cfset col["isPK"] = (IS_PK EQ 1)>
	<cfset ArrayAppend(tableObj["columns"], col)>
</cfloop>
<cfif prevTable NEQ "">
	<cfset ArrayAppend(tableData, tableObj)>
</cfif>

<!--- Build FK data --->
<cfset fkData = []>
<cfloop query="qFK">
	<cfset fk = StructNew()>
	<cfset fk["fk_table"]  = FK_TABLE>
	<cfset fk["fk_column"] = FK_COLUMN>
	<cfset fk["pk_table"]  = PK_TABLE>
	<cfset fk["pk_column"] = PK_COLUMN>
	<cfset ArrayAppend(fkData, fk)>
</cfloop>

<style>
#diagram-container {
	overflow: auto;
	height: calc(100vh - 56px);
	background: #d4d0c8;
}
#diagram {
	position: relative;
	min-height: 100%;
}
#lines-svg {
	position: absolute;
	top: 0;
	left: 0;
	pointer-events: none;
	z-index: 0;
}
#table-grid {
	display: flex;
	flex-wrap: wrap;
	gap: 24px;
	padding: 24px;
	position: relative;
	z-index: 1;
	align-items: flex-start;
}
.table-box {
	border: 1px solid #555;
	min-width: 160px;
	background: white;
	box-shadow: 2px 2px 5px rgba(0,0,0,0.25);
	flex-shrink: 0;
}
.table-header {
	background: #336699;
	color: white;
	font-weight: bold;
	padding: 5px 10px;
	font-size: 13px;
	font-family: Tahoma, Arial, sans-serif;
	cursor: default;
	white-space: nowrap;
}
.col-row {
	padding: 2px 10px;
	font-size: 12px;
	font-family: Tahoma, Arial, sans-serif;
	border-top: 1px solid #eee;
	white-space: nowrap;
}
.pk-col {
	font-weight: bold;
}
.col-row:hover {
	background: #e8f0fe;
}
</style>

<div id="diagram-container">
	<div id="diagram">
		<svg id="lines-svg"></svg>
		<div id="table-grid"></div>
	</div>
</div>

<span id="app-version" style="position:fixed;bottom:4px;right:8px;font-size:10px;color:#999;z-index:999;"></span>

<script>
var tables        = #serializeJSON(tableData)#
var relationships = #serializeJSON(fkData)#
</script>

<cfinclude template="/Inc/footer.cfm">
