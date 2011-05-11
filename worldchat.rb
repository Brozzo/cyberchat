$LOAD_PATH << "./"
require "rubygems"
require "data_mapper"
require "post.rb"
require "chatroom.rb"
DB = DataMapper.setup(:default, 'postgres://localhost/pzyfkcjkjl')

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
		session[:messages] = params[:messages]
		params[:messages] = "#{session[:name]} says: #{params[:message]}"
		$messages << params[:messages]
		"<p>#{message}</p>"
	end
	
	get "/style.css" do
		sass :style 
	end
end