class WorldChat < Sinatra::Application
	enable :sessions
	$ heroku addons
	logging:expanded
	newrelic:gold
	shared-database:5mb
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
		session[:messages] = params[:messages]
		params[:messages] = "#{session[:name]} says: #{params[:message]}"
		$messages << params[:messages]
		"<p>#{message}</p>"
	end
	
	get "/style.css" do
		sass :style 
	end
end