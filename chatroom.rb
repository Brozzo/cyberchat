require "rubygems"
require "data_mapper"
require "worldchat.rb"
class ChatRoom
	include DataMapper::Resource
	 has n, :Post
end