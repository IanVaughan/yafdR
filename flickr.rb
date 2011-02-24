#!/usr/bin/env ruby

require 'logger'

#https://github.com/reagent/fleakr
require 'fleakr'

log = Logger.new('log.txt')
log.debug "Log file created"

def load_keys(file)
  keys = {} #  keys = Hash.new {0}
  File.foreach(file) do |line|
    name, value = line.split(':')
    keys[name] = value
  end
  keys
end

puts "Loading keys..."
keys = load_keys('api_key.txt')

puts "Fleakr init..."
#Fleakr.api_key = "#{keys['api']}"
Fleakr.api_key = '304ae3719ef4fb2c91557c5e553f1e9c'

puts "Finding user..."
user = Fleakr.user('Ian Vaughan')

if user
  puts "User : #{user}"
  puts "User->id:#{user.id}"
  puts "User->username:#{user.username}"
#  puts "Count : #{user.photos.count}"
#  puts "title :" + user.photos.first.title
#  puts "url :" + user.photos.first.small.url
#  puts "url :" + user.photos.first.original.url
#  puts "comments :" + user.photos.first.original.comments
#  user.photos.first.original.save_to('.')

  # loop user.sets
  puts "Getting sets..."
  sets = user.sets
  # set =
  sets.each do |set|
    puts set
    puts "Set id : #{set.id}"
    puts "Set title : #{set.title}"
    puts "Set count : #{set.count}"

    puts "Getting photos from set..."
    photos = set.photos

    photos.each do |photo|
      puts "Photo->id:#{photo.id}"
      puts "Photo->title:#{photo.title}"
      puts "Photo->secret:#{photo.secret}"
      puts "Photo->farm_id:#{photo.farm_id}"
      puts "Photo->server_id_id:#{photo.server_id}"
      puts "Photo->farm_id:#{photo.farm_id}"
      puts "Photo->original.url:#{photo.original.url}"


    end


  end

end

