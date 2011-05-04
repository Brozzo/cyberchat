$(document).ready (function() {
	$("#post").submit(function(e){
		$.post("/chat",$(this).serialize(),
		function(response){
			$("#message_area").prepend(response)
		})
		e.preventDefault()
	})
})

