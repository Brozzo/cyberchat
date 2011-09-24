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
	
	get "/style.css" do
		sass :style
	end
	
	post "/messages" do
		session[:name] = params[:name]
		message = params[:message]
		message2 = message.scan(/\w+/)
		
		message2.each do |x|
			l = message.length
			if @@badwords.any? {|badwords| x.include? badwords}
				message = ''
				l.times {message = message + '*'}
			end
		end
		
		if @@badnames.any? {|badnames| session[:name].downcase.include? badnames}
			message = "Anonymous says: " + message
		else
			message = "#{session[:name].capitalize} says: " + message
		end
		
		hour = Time.now.hour
		minute = Time.now.min
		
		case hour
		when (0..14) then hour += 9
		else hour -= 15
		end
		
		case minute
		when (0..9) then tiden = hour.to_s + ':' + '0' + minute.to_s
		else tiden = hour.to_s + ':' + minute.to_s
		end
		
		if (params[:message].length != 0 and session[:name].length != 0)
			$messages << message + ' ' + '-' + ' ' + tiden
			"<p>#{message}</p>"
		end
		
	end
end