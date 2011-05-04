class WorldChat < Sinatra::Application
	enable :sessions
	$messages =[]
	
	get "/" do
		haml :chattboy
	end
	
	post "/chat" do
		session[:name] = params[:name]
		message = "#{session[:name]} says: #{params[:message]}"
		$messages << message
		"<p>#{message}</p>"
	end
	
	get "/style.css" do
		sass :style 
	end
end