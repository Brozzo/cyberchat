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
			if hour == 0 or if hour == 1 or if hour == 2 or if hour == 3 or if hour == 4 or if hour == 5 or if hour == 6 or if hour == 7 or if hour == 8 or if hour == 9 or if hour == 10 or if hour == 11 or if hour == 12 or if hour == 13 or if hour == 14
				hour = hour + 9
			elsif hour == 15
				hour = 0
			elsif hour == 16
				hour = 1
			elsif hour == 17
				hour = 2
			elsif hour == 18
				hour = 3
			elsif hour == 19
				hour = 4
			elsif hour == 20
				hour = 5
			elsif hour == 21
				hour = 6
			elsif hour == 22
				hour = 7
			elsif hour == 23
				hour = 8
			if minute == 0 or minute == 1 or minute == 2 or minute == 3 or minute == 4 or minute == 5 or minute == 6 or minute == 7 or minute == 8 or minute == 9 
				tiden = " " + hour.to_s + ":" + "0" + minute.to_s
			else
				tiden = " " + hour.to_s + ":" + minute.to_s
			end
			$messages << message + "/n" + tiden
			"<p>#{message}</p>"
		end
		
	get "/style.css" do
		sass :style 
	end
end
