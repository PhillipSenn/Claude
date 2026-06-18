$('#version').append(2)
$(document).on('mouseenter','.responses .bi',bi_responses)

function bi_responses() {
	var text = $(this).data('response')
	$(this).closest('.card').find('.response').html(text)
}