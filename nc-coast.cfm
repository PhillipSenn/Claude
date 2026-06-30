<cfinclude template="/Inc/header.cfm">


  <div class="row">
    <div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 text-center">


      <div id="photo-frame" class="mb-3" style="overflow:hidden;">
        <img id="photo-img" src="" alt="" class="img-rounded img-thumbnail" style="width:100%; display:block;">
      </div>
      <style>
        @media (min-width: 1400px) { #caption-block { width: auto !important; flex-grow: 1; } }
      </style>
      <div class="d-flex flex-wrap align-items-center justify-content-between">
        <div id="caption-block" class="order-0 order-xxl-1 w-100 text-center">
          <p id="photo-caption" class="text-muted mb-0" style="font-style:italic; min-height:1.5em;"></p>
          <p id="photo-counter" class="text-muted small mb-1"></p>
        </div>
        <button class="btn btn-outline-secondary nc-prev order-1 order-xxl-0">&laquo; Prev</button>
        <button class="btn btn-outline-secondary nc-next order-2">Next &raquo;</button>
      </div>

    </div>
  </div>

<a href="nc-coast.cfm" class="nav-link">NC Coast Grill &amp; Bar</a>
<div class="nav-item">&bull; v9</div>

<cfinclude template="/footer.cfm">
<cfinclude template="/Inc/footer.cfm">
