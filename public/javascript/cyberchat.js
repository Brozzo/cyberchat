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

function commands() {
	var mess = document.getElementById('input2')
	if(mess.value == '/commands')
		alert("Commands:\n\n/commands,\n\n/color #color,\n\n/bgcolor #color")
}