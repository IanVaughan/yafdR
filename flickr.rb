#!/usr/bin/env ruby
require 'logger'
require 'fleakr'  #https://github.com/reagent/fleakr

log = Logger.new('log.txt')

def load_keys(file)
  # should find "api:", "username:"
  keys = {}
  File.foreach(file) do |line|
    name, value = line.split(':')
    keys[name.to_sym] = value.to_s.chomp
  end
  keys
end

def loop_photos(photos)
  log.info "Getting number of photos..."
  number_photos = photos.count
  log.debug "Number of photos:#{number_photos}"

  photos.each_with_index do |photo, count|
    log.debug "photo:#{count}/#{number_photos}"
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

def loop_sets(sets)
  log.info "Getting number of sets..."
  number_sets = sets.count
  log.debug "Number of sets:#{number_sets}"

  sets.each_with_index do |set, count|
    log.info "------------------------------------------------------------"
    log.debug "set:#{count}/#{number_sets}"
    log.debug "Set id : #{set.id}"
    log.debug "Set title : #{set.title}"
    log.debug "Set count : #{set.count}"
    log.info ""

    log.info "Getting photos from set..."
    photos = set.photos
    photos ? loop_photos(photos) : log.error("Getting photos failed!")
  end
end


log.info "*********************************************************"
log.info "Loading keys..."
keys = load_keys('api_key.txt')

log.debug "api:#{keys[:api]}"
log.debug "secret:#{keys[:secret]}"
log.debug "username:#{keys[:username]}"

log.info "Fleakr init..."
Fleakr.api_key = "#{keys[:api]}"

log.info "Finding user : #{keys[:username]}..."
user = Fleakr.user("#{keys[:username]}")

if user
  log.debug "User->id:#{user.id}"
  log.debug "User->username:#{user.username}"
  log.debug "User->photos.count : #{user.photos.count}"

  log.info "Getting sets..."
  sets = user.sets
  sets ? loop_sets(sets) : log.error("Getting sets failed!")
else
  log.error "User not found : #{keys[:username]}"
end

