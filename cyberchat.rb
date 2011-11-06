require 'rubygems'
require './badwords.rb'
require 'sass'

class CyberChat < Sinatra::Application
	
	set :username, '1337'
	set :password, 'cyberchat'
	set :admin_username, 'Masterofthis'
	set :admin_password, 'gosebrozz1'
	@@admin, @@login = false, false
	enable :sessions
	$messages = []
	
	get ("/style.css") {sass :style}
	
	get "/" do
		session[:admin] = false
		@@login, @@admin = false, false
		haml :startpage
	end
	
	get "/chat" do
		if (@@admin or @@login or session[:admin] == 'admin' or session[:admin] == 'user')
			@@login, @@admin = false, false
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
			session[:admin] = 'admin'
			redirect "/chat"
		elsif (params[:username] == settings.username and params[:password] == settings.password)
			session[:admin] = 'user'
			@@login = true
			redirect "/chat"
		else
			session[:admin] = false
			@@login, @@admin = false, false
			"<h1>Incorrect password!</h1>"
		end
		haml :login
	end
	
	post "/messages" do
		
		session[:name] = params[:name]
		message = params[:message]
		command = message.split
		delete = false
		
		if session[:admin] == 'admin'
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
		
		if command.any? {|word| word =~ @@badwords}
			message = ''
			command.each do |x|
				l = x.length
				if x =~ @@badwords
					l.times {message += '*'}
					message += ' '
				else
					message += "#{x} "
				end
			end
		end
		
		if session[:name].downcase =~ @@badnames
			message = "Anonymous says: #{message}"
		else
			message = "#{session[:name]} says: #{message}"
		end
		
		hour = Time.now.hour
		minute = Time.now.min
		
		case hour; when (0..14) then hour += 9; else hour -= 15; end
		case minute; when (0..9) then time = "#{hour}:0#{minute}"
		else time = "#{hour}:#{minute}"; end
		
		if (params[:message].length > 0 and session[:name].length > 0 and not delete)
			message += " - #{time}"
			$messages << message
		end
		
		message_num = 0
		$messages.each {message_num += 1}
		$messages.delete_at(0) if message_num > 40
		"<p>#{message}</p>"
	end
end