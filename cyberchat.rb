class CyberChat < Sinatra::Application
	enable :sessions
	$messages =[]
	
	get "/" do
		haml :chattboy
	end
	
	get "/fetch_messages" do
		$messages.reverse.map do |m|
		"<p>#{m}</p>"
		end.join 
	end
		post "/chat" do
			session[:name] = params[:name]
			message = "#{session[:name].capitalize} says: #{params[:message]}"
			added_time = ""
			hour = Time.now.hour
			minute = Time.now.min
			if minute == 0 or minute == 1 or minute == 2 or minute == 3 or minute == 4 or minute == 5 or minute == 6 or minute == 7 or minute == 8 or minute == 9 
				tiden = " " + hour.to_s + ":" + "0" + minute.to_s
			else
				tiden = " " + hour.to_s + ":" + minute.to_s
			end
			$messages << message + tiden
			"<p>#{message}</p>"
		end
		
	get "/style.css" do
		sass :style 
	end
end
