require "./badwords.rb"
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
			added_time = ""
			hour = Time.now.hour
			minute = Time.now.min
			if @@badnames.any? {|badnames| session[:name].downcase.include? badnames}
				message = "Anonymos says: #{params[:message]}"
			else
				message = "#{session[:name].capitalize} says: #{params[:message]}"
			end
			if hour == 0 or hour == 1 or hour == 2 or hour == 3 or hour == 4 or hour == 5 or hour == 6 or hour == 7 or hour == 8 or hour == 9 or hour == 10 or hour == 11 or hour == 12 or hour == 13 or hour == 14
				hour = hour + 9
			elsif hour == 15 or hour == 16 or hour == 17 or hour == 18 or hour == 19 or hour == 20 or hour == 21 or hour == 22 or hour == 23
				hour = hour - 15
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
end