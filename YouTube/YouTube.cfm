<cfinclude template="/Inc/cfm/YouTube.cfm">
<cfinclude template="/Inc/header.cfm">
<link rel="stylesheet" href="YouTube.css">

<div class="container-fluid mt-3">
  <div id="video-container">

    <!--- Sticky progress bar --->
    <div class="sticky-top bg-white border-bottom py-2 mb-2">
      <div class="d-flex align-items-center mb-1">
        <span id="pct-label" class="font-weight-bold mr-3">0% complete</span>
        <span id="segment-label" class="text-muted small mr-3"></span>
        <button id="resume-btn" class="btn btn-success btn-sm" style="display:none">&#9654; Resume</button>
      </div>
      <div class="progress mb-0" style="height:26px">
        <div id="progress-bar"
             class="progress-bar progress-bar-striped"
             role="progressbar"
             style="width:0%"
             aria-valuenow="0"
             aria-valuemin="0"
             aria-valuemax="100">0%</div>
      </div>
    </div>

    <div class="row">

      <div class="col-md-8">
        <h2 id="video-title" class="mb-2"></h2>

        <div class="video-responsive mb-2">
          <div id="yt-player"></div>
        </div>

        <div id="video-description"
             class="text-muted small border rounded p-2 mt-2"
             style="white-space:pre-wrap;display:none"></div>

        <div id="watched-segments" class="mt-3" style="display:none">
          <h5>Watched Segments</h5>
          <table class="table table-sm table-bordered">
            <thead class="thead-light">
              <tr>
                <th>Start</th>
                <th>End</th>
                <th>Duration</th>
              </tr>
            </thead>
            <tbody id="segments-tbody"></tbody>
          </table>
        </div>
      </div>

      <div id="transcript-panel" class="col-md-4" style="display:none">
        <h4>Transcript</h4>
        <div id="transcript-container"></div>
      </div>

    </div>
  </div>

  <div class="row mt-4">
    <div class="col-md-12">
      <form id="video-form">
        <div class="row">
          <div class="col-md-4">
            <div class="form-group">
              <label for="video-id">YouTube Video ID</label>
              <input type="text" id="video-id" class="form-control" value="8kK2zwjRV0M" placeholder="e.g. dQw4w9WgXcQ">
            </div>
          </div>
          <div class="col-md-3">
            <div class="form-group">
              <label for="start-sec">Start (sec)</label>
              <input type="number" id="start-sec" class="form-control" value="450" min="0">
            </div>
          </div>
          <div class="col-md-3">
            <div class="form-group">
              <label for="end-sec">End (sec)</label>
              <input type="number" id="end-sec" class="form-control" value="550" min="0">
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>

  <div class="row mt-1">
    <div class="col-md-12">
      <small class="text-muted" id="app-version"></small>
      <span class="card-header" style="display:none"></span>
      <span id="status-bar" style="display:none"></span>
    </div>
  </div>

</div>

<!--- Question data (hidden from view) --->
<div hidden id="question-data">
	<div class="q" data-ts="460">Question 1</div>
	<div class="ans">Answer 1</div>
	<div class="ans">Answer 2</div>
	<div class="ans">Answer 3</div>
	<div class="ans">Answer 4</div>
	<div class="q">Question 2</div>
	<div class="ans">Answer a</div>
	<div class="ans">Answer b</div>
	<div class="ans">Answer c</div>
	<div class="ans">Answer d</div>
</div>

<!--- Question modal --->
<div class="modal fade" id="question-modal" tabindex="-1" role="dialog"
     data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modal-question-text"></h5>
      </div>
      <div class="modal-body" id="modal-answers"></div>
      <div class="modal-footer">
        <button type="button" id="modal-submit-btn" class="btn btn-primary">Submit</button>
      </div>
    </div>
  </div>
</div>

<a class="nav-link">YouTube</a>
<script src="../Inc/JS/get_json.js"></script>
<cfinclude template="/Inc/footer.cfm">
