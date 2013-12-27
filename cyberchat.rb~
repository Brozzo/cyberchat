require 'rubygems'
require 'data_mapper'
require './badwords.rb'
require 'sass'

#DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/cyberchat.db")

class CyberChat < Sinatra::Application
	
	set :username, '1337'
	set :password, 'cyberchat'
	set :admin_username, 'Masterofthis'
	set :admin_password, 'gosebrozz1'
	@login = false
	enable :sessions
	$messages = []
	$color = ['#00FF00', '#000000']
	
	get ("/style.css") {sass :style}
	get ("/") {haml :startpage}
	
	get "/chat" do
		if (@login or session[:admin])
		else
			redirect "/"
		end
		haml :chat
	end
	
	get "/fetch_messages" do
		$messages.reverse.map {|m| "<p><font color=\"#{$color[0]}\">#{m}</font><br><input class=\"\" type=\"button\" value=\"-X-\"></input></p>"}.join + "<style type=\"text/css\">\nbody {\n\tbackground-color: #{$color[1]}\n}\n</style>"
	end
	
	post "/login" do
		if (params[:username] == settings.admin_username and params[:password] == settings.admin_password)
			@login = true
			session[:admin] = 'admin'
			redirect "/chat"
		elsif (params[:username] == settings.username and params[:password] == settings.password)
			session[:admin] = 'user'
			@login = true
			redirect "/chat"
		else
			session[:admin] = false
			@login = false
		end
		haml :login
	end
	
	get "/logout" do
		session[:admin] = false
		@login = false
		redirect "/"
	end
	
	post "/messages" do
		
		session[:name] = params[:name]
		message = params[:message]
		command = message.split
		delete = false
		
		if session[:admin] == 'admin' #admin commands
			if command[0].downcase == '/delete'
				if command[1].to_i != 0
					num = command[1].to_i - 1
					$messages.delete_at(num)
					delete = true
				end
			elsif command[0].downcase == '/deleteall'
				$messages = []
				delete = true
			end
		end
		
		#free commands
		if command[0].downcase == '/color'
			$color[0] = command[1]
			delete = true
		elsif command[0].downcase == '/bgcolor'
			$color[1] = command[1]
			delete = true
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
			name = "Anonymous"
		else
			name = "#{session[:name]}"
		end
		
		hour = Time.now.hour
		minute = Time.now.min
		
		case hour; when (0..14) then hour += 9; else hour -= 15; end
		case minute; when (0..9) then time = "#{hour}:0#{minute}"
		else time = "#{hour}:#{minute}"; end
		
		message = "C:\\cyberchat\\#{name}\\#{time}> #{message}"
		
		num, mess = 0, ''
		message.each_char do |char|
			num += 1
			if (num == 60 or num == 114) then mess += char + '<br>'
			else mess += char
			end
		end
		
		if (params[:message].length > 0 and session[:name].length > 0 and not delete)
			$messages << mess
		end
		
		message_num = 0
		$messages.each {message_num += 1}
		$messages.delete_at(0) if message_num > 40
		$messages.delete_if {|m| m =~ /C:\\cyberchat\\.*\\.*> \/commands/}
	end
end