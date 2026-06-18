<cfscript>
//request.container = 'container-fluid'
include '/Inc/header.cfm'
</cfscript>

<cfoutput>
<div class="row">
	<div class="col-xl-4">
		<div class="card">
			<div class="card-header bg-success-subtle">
				The New York Times
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card">
			<div class="card-header bg-primary-subtle">
				John
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card">
			<div class="card-header bg-info-subtle">
				Classroom responses
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				With the school year ending, all over the country educators and parents are taking stock of the drastic shift caused by artficial intelligence in the classroom.
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				<textarea name="yourThought" autofocus></textarea>
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				<table class="responses">
					<thead>
						<tr>
							<th>A</th>
							<th>B</th>
							<th>C</th>
							<th>D</th>
							<th>E</th>
							<th>F</th>
							<th>G</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td title="Caleb">
								<i class="bi bi-person-raised-hand text-primary"
								data-response="My school year hasn't ended yet!"></i>
							</td>
							<td></td>
							<td>
							</td>
							<td></td>
							<td title="Jakob">
								<span class="bi bi-patch-exclamation text-primary"
								data-response="typo: artficial"></span>
							</td>
							<td></td>
							<td></td>
						</tr>
						
					</tbody>
				</table>
			</div>
			<div class="card-footer"></div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				Today, Natasha Singer, a technology reporter, discusses the year that reshaped American classrooms and how one dedicated teacher helped his students chart their own path into an uncertain future.</p>
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				<textarea name="yourThought"></textarea>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				<p>On Today’s Episode</p>
				<p>Natasha Singer, a technology reporter for The New York Times.</p>
				<img src="https://static01.nyt.com/images/2026/06/17/multimedia/17DAILY-AISchool-02-jmvp/17DAILY-AISchool-02-jmvp-superJumbo.jpg" class="img-fluid">
				<p>A teacher leans over a desk to assist high school students who are working on laptops and writing in notebooks in a classroom setting.</p>
				<p>This teacher in Newark developed chatbots for his U.S. history classes to help his students hone their argumentative writing.Credit...Juan Arredondo for The New York Times</p>
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				<textarea name="yourThought"></textarea>
			</div>
		</div>
	</div>

	<div class="col-xl-4">
		<div class="card">
			<div class="card-body">
				<table class="responses">
					<tbody>
						<tr>
							<td>
							</td>
							<td></td>
							<td title="Bob">
								<span class="bi bi-patch-question-fill text-danger"
								data-response="What about xyz?"></span>
							</td>
							<td></td>
							<td>
							</td>
							<td></td>
							<td></td>
						</tr>
						
					</tbody>
				</table>
			</div>
			<div class="card-footer"></div>
		</div>
	</div>

</div>
<a class="nav-link active" href="#request.script_name#">Transcript</a>
<div class="nav-item" id="version">&bull; v</div>
<script src="/Inc/js/autosize.js"></script>
<cfinclude template="/Inc/footer.cfm">
</cfoutput>