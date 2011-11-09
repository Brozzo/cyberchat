function fetchMessages(){
	$.get("/fetch_messages",
	function(response){
		$('#message_area').empty()
		$('#message_area').append(response)
	})
}
$(document).ready (function() {
	$("#post").submit(function(e){
  	e.preventDefault()
		$.post("/messages", $(this).serialize() )
		$("#input2").val("")
	})
	setInterval('fetchMessages()',1000
)	
})