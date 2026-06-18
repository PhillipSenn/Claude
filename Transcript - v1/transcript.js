$('#version').append(1)
$(document).on('mouseenter','#responses .bi',bi_response)

function bi_response() {
	var text = $(this).data('response')
	$('#response').html(text)
}