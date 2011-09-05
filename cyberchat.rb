require "./badwords.rb"
class CyberChat < Sinatra::Application
	enable :sessions
	$messages =[]
	get "/" do
		haml :startpage
	end
	get "/chat" do
		haml:chat
	end
	get "/fetch_messages" do
		$messages.reverse.map do |m|
		"<p>#{m}</p>"
		end.join 
	end
		post "/messages" do
			session[:name] = params[:name]
			if @@badnames.any? {|badnames| session[:name].downcase.include? badnames}
				message = "Anonymous says: #{params[:message]}"
			else
				message = "#{session[:name].capitalize} says: #{params[:message]}"
			end
			hour = Time.now.hour
			minute = Time.now.min
			if (0..14) === hour
				hour = hour + 9
			else
				hour = hour - 15
			end
			if (0..9) === minute
				tiden = hour.to_s + ":" + "0" + minute.to_s
			else
				tiden = hour.to_s + ":" + minute.to_s
			end
			if params[:message].length != 0 and session[:name].length != 0
				$messages << message + " " + tiden
				"<p>#{message}</p>"
			end
		end
	get "/style.css" do
		sass :style 
	end
end