function fetchMessages(){
	$.get("/fetch_messages",
	function(response){
		$('#message_area').empty()
		$('#message_area').prepend(response)
	})
}
$(document).ready (function() {
	$("#post").submit(function(e){
  	e.preventDefault()
		$.post("/messages", $(this).serialize() )
		$("#mess").val("")
	})
	setInterval('fetchMessages()',1000
)	
})