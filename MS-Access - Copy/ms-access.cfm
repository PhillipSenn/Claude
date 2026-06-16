<!--- ms-access.cfm --->
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

<div id="diagram-container">
	<div id="diagram">
		<svg id="lines-svg"></svg>
		<div id="table-grid"></div>
	</div>
</div>

<table id="tableData" style="display:none">
	<tbody>
		<cfoutput query="qColumns">
		<tr>
			<td>#TABLE_NAME#</td>
			<td>#COLUMN_NAME#</td>
			<td>#IS_PK#</td>
		</tr>
		</cfoutput>
	</tbody>
</table>

<table id="tableRelationships" style="display:none">
	<tbody>
		<cfoutput query="qFK">
		<tr>
			<td>#FK_TABLE#</td>
			<td>#FK_COLUMN#</td>
			<td>#PK_TABLE#</td>
			<td>#PK_COLUMN#</td>
		</tr>
		</cfoutput>
	</tbody>
</table>

<a class="nav-link">Relationships</a>
<a class="nav-item" id="app-version"></a>
<cfinclude template="/Inc/footer.cfm">
