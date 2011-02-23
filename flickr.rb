#https://github.com/reagent/fleakr
require 'fleakr'

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
Fleakr.api_key = "#{keys['api']}"

puts "Finding user..."
user = Fleakr.user('Ian Vaughan')

puts "User : #{user}"

if user
  puts "Count : #{user.photos.count}"
  puts "title :" + user.photos.first.title
  puts "url :" + user.photos.first.small.url
  puts "url :" + user.photos.first.original.url
#  puts "comments :" + user.photos.first.original.comments
  user.photos.first.save_to('.')
end

