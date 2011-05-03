
class WorldChat < Sinatra::Application
	enable :sessions
	$messages =[]
	get "/" do
	haml :chattboy
	end
	post "/chatt" do
	session[:name] = params[:name]
		$messages << "#{session[:name]} says:
		#{params[:message]}"
	redirect "/"
	end
	get "/style.css" do
	sass :style 
	end
end