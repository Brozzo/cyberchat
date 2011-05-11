require "rubygems"
require "data_mapper"
DB = DataMapper.setup(:default, 'postgres://localhost/')
class Post
	include DataMapper::Resource
end
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
			message = "#{session[:name]} says: #{params[:message]}"
			$messages << message
			"<p>#{message}</p>"
		end
	
	get "/style.css" do
		sass :style 
	end
end



'postgress://pzyfkcjkjl:tZxQ706GPZt8DkUkFD0w@ec2-50-19-113-83.compute-1.amazonaws.com/pzyfkcjkjl')
