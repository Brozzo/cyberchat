require 'rubygems'
require './badwords.rb'
require 'sass'

class CyberChat < Sinatra::Application
	
	set :username, '1337'
	set :password, 'cyberchat'
	set :admin_username, 'Masterofthis'
	set :admin_password, 'gosebrozz1'
	@@num = 1
	@@admin, @@login = false, false
	enable :sessions
	$messages = []
	
	get ("/style.css") {sass :style}
	
	get "/" do
		@@login, @@admin = false, false
		@@num = 1
		haml :startpage
	end
	
	get "/chat" do
		if @@num == 2
			redirect "/"
		elsif (@@login or @@admin)
			@@num = 2
		else
			redirect "/"
		end
		haml :chat
	end
	
	get "/fetch_messages" do
		$messages.reverse.map do |m|
		"<p>#{m}</p>"
		end.join
	end
	
	post "/login" do
		if (params[:username] == settings.admin_username and params[:password] == settings.admin_password)
			@@admin = true
			redirect "/chat"
		elsif (params[:username] == settings.username and params[:password] == settings.password)
			@@login = true
			redirect "/chat"
		else
			@@login, @@admin = false, false
			"<h1>Incorrect password!</h1>"
		end
		haml :login
	end
	
	post "/messages" do
		
		session[:name] = params[:name]
		message = ': ' + params[:message]
		command = params[:message].split
		delete = false
		
		if @@admin
			if command[0].downcase == 'deletemessage'
				if command[1].to_i != 0
					num = command[1].to_i - 1
					$messages.delete_at(num)
					delete = true
				end
			elsif command[0].downcase == 'deleteallmessages'
				$messages = []
				delete = true
			end
		end
		
		command.each do |x|
			l = message.length
			if @@badwords.any? {|badwords| x.include? badwords}
				message = ''
				l.times {message = message + '*'}
			end
		end
		
		if @@badnames.any? {|badnames| session[:name].downcase.include? badnames}
			message = "Anonymous says" + message
		else
			message = "#{session[:name]} says" + message
		end
		
		hour = Time.now.hour
		minute = Time.now.min
		
		case hour; when (0..14) then hour += 9; else hour -= 15; end
		case minute; when (0..9) then time = hour.to_s + ':' + '0' + minute.to_s; else time = hour.to_s + ':' + minute.to_s; end
		
		if (params[:message].length != 0 and session[:name].length != 0 and not delete)
			$messages << message + ' - ' + time
		end
		
		message_num = 0
		$messages.each {message_num += 1}
		if message_num > 40 then $messages.delete_at(0); end
	end
end