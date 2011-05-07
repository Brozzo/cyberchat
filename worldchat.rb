class WorldChat < Sinatra::Application
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
		message = "#{session[:name]} says: #{params[:message]}"
		$messages << message
		"<p>#{message}</p>"
	end
	
	get "/style2.css" do
		sass :style 
	end
end