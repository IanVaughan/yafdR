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
    keys[name.to_sym] = value.to_s
  end
  keys
end

log.debug "Loading keys..."
keys = load_keys('api_key.txt')

log.debug "Fleakr init..."
Fleakr.api_key = "#{keys[:api]}"
#Fleakr.api_key = '304ae3719ef4fb2c91557c5e553f1e9c'

log.debug "Finding user..."
user = Fleakr.user('Ian Vaughan')

if user
  log.debug "User->id:#{user.id}"
  log.debug "User->username:#{user.username}"
#  puts "Count : #{user.photos.count}"
#  puts "title :" + user.photos.first.title
#  puts "url :" + user.photos.first.small.url
#  puts "url :" + user.photos.first.original.url
#  puts "comments :" + user.photos.first.original.comments
#  user.photos.first.original.save_to('.')

  # loop user.sets
  log.debug "Getting sets..."
  sets = user.sets

  if sets
    number_sets = sets.count
    log.debug "Number of sets:#{number_sets}"

    set_number = 0

    sets.each do |set|
      #puts set
      log.debug "------------------------------------------------------------"
      log.debug "set:#{set_number}/#{number_sets}"
      set_number += 1
      log.debug "Set id : #{set.id}"
      log.debug "Set title : #{set.title}"
      log.debug "Set count : #{set.count}"


      log.debug ""
      log.debug "Getting photos from set..."
      photos = set.photos

      if photos
        number_photos = photos.count
        log.debug "Number of photos:#{number_photos}"
        photo_number = 0

        photos.each do |photo|
          log.debug "photo:#{photo_number}/#{number_photos}"
          photo_number+=1

          log.debug "Photo->id:#{photo.id}"
          log.debug "Photo->title:#{photo.title}"
          log.debug "Photo->secret:#{photo.secret}"
          log.debug "Photo->farm_id:#{photo.farm_id}"
          log.debug "Photo->server_id_id:#{photo.server_id}"
          log.debug "Photo->farm_id:#{photo.farm_id}"
          log.debug "Photo->original.url:#{photo.original.url}"
          log.debug ""
        end

      end
    end
  end
end

