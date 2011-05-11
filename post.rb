require "rubygems"
require "data_mapper"
require "worldchat.rb"
class Post
	include DataMapper::Resource
	property :id,         Serial    # An auto-increment integer key
	property :title,      String    # A varchar type string, for short strings
	property :body,       Text      # A text block, for longer string data.
	property :created_at, DateTime  # A DateTime, for any date you might like.
	belongs_to :chatroom
end