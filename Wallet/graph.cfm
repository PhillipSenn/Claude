<cfscript>
include '/Inc/header.cfm'
</cfscript>

<div class="row g-2 align-items-end mb-3">
	<div class="col-12 col-lg-6">
		<label class="form-label small mb-1" for="address">Seed address</label>
		<div class="form-control font-monospace" id="address" contenteditable="plaintext-only" spellcheck="false">0xCE9De01156BC1281bAC9254e49ba5D325BF2F6d8</div>
	</div>
	<div class="col-6 col-lg-3">
		<label class="form-label small mb-1" for="network">Network</label>
		<select class="form-select" id="network">
			<option value="flare" selected>Flare</option>
			<option value="songbird">Songbird</option>
			<option value="coston2">Coston2</option>
		</select>
	</div>
	<div class="col-6 col-lg-3">
		<label class="form-label small mb-1" for="maxCounterparties">Max counterparties</label>
		<input class="form-control" id="maxCounterparties" type="number" min="1" max="50" value="12">
	</div>
</div>

<div class="row g-3">
	<div class="col-lg-9">
		<svg class="graph" id="graph" viewBox="0 0 900 600" xmlns="http://www.w3.org/2000/svg">
			<g id="edgesLayer"></g>
			<g id="nodesLayer"></g>
		</svg>
		<p class="text-secondary small mt-2 mb-0" id="status">Loading&hellip;</p>
	</div>
	<div class="col-lg-3">
		<div class="card">
			<div class="card-header py-2">Selected wallet</div>
			<div class="card-body" id="details">
				<p class="text-secondary small mb-0">Click a wallet to see its details.</p>
			</div>
		</div>
		<p class="text-secondary small mt-3 mb-0">
			Edit the seed address, network, or max counterparties to reload the graph.
			Click a wallet to expand its counterparties.
			Drag a wallet to pin it and slacken its connections so you can spread out the board.
			Names you give wallets are remembered on this device.
			Edge thickness shows how many transactions connect two wallets.
		</p>
	</div>
</div>

<a class="nav-link" href="<cfoutput>#request.script_name#</cfoutput>">Wallet Graph</a>
<a class="nav-item" id="app-version"></a>
<cfinclude template="/Inc/footer.cfm">
