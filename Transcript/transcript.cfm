<cfscript>
//request.container = 'container-fluid'
include '/Inc/header.cfm'
</cfscript>

<cfoutput>
<div class="row">
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-header bg-success-subtle">
				<a class="text-body" href="https://www.nytimes.com/2026/06/17/podcasts/the-daily/battle-over-ai-in-school.html">
				The Battle Over A.I. in the Classroom
				</a>
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-header bg-primary-subtle">
				John
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-header bg-info-subtle">
				Classroom responses
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				With the school year ending, all over the country educators and parents are taking stock of the drastic shift caused by artficial intelligence in the classroom.
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				<textarea name="yourThought" autofocus></textarea>
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				<table class="responses">
					
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
								<span class="bi bi-magic text-info"
								data-response="typo: artficial"></span>
							</td>
							<td></td>
							<td></td>
						</tr>
						
					</tbody>
				</table>
				<p class="response"></p>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				Today, Natasha Singer, a technology reporter, discusses the year that reshaped American classrooms and how one dedicated teacher helped his students chart their own path into an uncertain future.
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				<textarea name="yourThought"></textarea>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				<figure>
					<a href="https://static01.nyt.com/images/2026/06/17/multimedia/17DAILY-AISchool-02-jmvp/17DAILY-AISchool-02-jmvp-superJumbo.jpg">
						<img alt="A teacher leans over a desk to assist high school students who are working on laptops and writing in notebooks in a classroom setting." src="https://static01.nyt.com/images/2026/06/17/multimedia/17DAILY-AISchool-02-jmvp/17DAILY-AISchool-02-jmvp-superJumbo.jpg" class="figure-img img-fluid">
					</a>
					<figcaption>This teacher in Newark developed chatbots for his U.S. history classes to help his students hone their argumentative writing.Credit...Juan Arredondo for The New York Times</figcaption>
				</figure>
			</div>
		</div>
	</div>
	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				<textarea name="yourThought"></textarea>
			</div>
		</div>
	</div>

	<div class="col-xl-4">
		<div class="card h-100">
			<div class="card-body">
				<table class="responses">
					<tbody>
						<tr>
							<td>
							</td>
							<td></td>
							<td title="Bob">
								<span class="bi bi-patch-question-fill text-danger"
								data-response="What if they didn't bring their laptop to class that day?"></span>
							</td>
							<td></td>
							<td>
							</td>
							<td></td>
							<td title="Artimus">
								<i class="bi bi-exclamation-octagon-fill text-warning" data-response="Dude's using a pen and paper on top of his laptop."></i>
							</td>
						</tr>
						
					</tbody>
				</table>
				<p class="response"></p>
			</div>
		</div>
	</div>

</div>
<a class="nav-link active" href="#request.script_name#">Transcript</a>
<div class="nav-item">&bull; v3</div>
<script src="/Inc/js/autosize.js"></script>
<cfinclude template="/footer.cfm">
<cfinclude template="/Inc/footer.cfm">
</cfoutput>