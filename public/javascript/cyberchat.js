function fetchMessages(){
	$.get("/fetch_messages",
	function(response){
		$('#message_area').empty()
		$('#message_area').prepend( "<div> <button type=\"button\">delete</button>" + response + "</div>" )
	})
}
$(document).ready (function() {
	$("#post").submit(function(e){
  	e.preventDefault()
		$.post("/chat", $(this).serialize() )
		$("#mess").val("")
	})
	setInterval('fetchMessages()',1000
)	
})
