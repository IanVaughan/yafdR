require 'logger'
require 'fleakr'  #https://github.com/reagent/fleakr

class Yafdl

  def initialize(file)
    @log = Logger.new('log.txt')
    @log.info "*********************************************************"
    @keys = load_keys(file)
    @log.debug "api:#{@keys[:api]}"
    @log.debug "secret:#{@keys[:secret]}"
    @log.debug "username:#{@keys[:username]}"

    @log.info "Fleakr init..."
    Fleakr.api_key = "#{@keys[:api]}"
  end

  def loop_photos(photos)
    @log.info "Getting number of photos..."
    number_photos = photos.count
    @log.debug "Number of photos:#{number_photos}"

    photos.each_with_index do |photo, count|
      @log.debug "photo:#{count}/#{number_photos}, id:#{photo.id}, title:#{photo.title}, secret:#{photo.secret}, farm_id:#{photo.farm_id}, server_id_id:#{photo.server_id}, farm_id:#{photo.farm_id}, original.url:#{photo.original.url}"
    end
  end

  def loop_sets(sets)
    @log.info "Getting number of sets..."
    number_sets = sets.count
    @log.debug "Number of sets:#{number_sets}"

    sets.each_with_index do |set, count|
      @log.info "------------------------------------------------------------"
      @log.debug "set:#{count}/#{number_sets}, id:#{set.id}, title:#{set.title}, count:#{set.count}"
      @log.info "Getting photos from set..."
      photos = set.photos
      photos ? loop_photos(photos) : @log.error("Getting photos failed!")
    end
  end

  def get_user
    @log.info "Finding user : #{@keys[:username]}..."
    user = Fleakr.user("#{@keys[:username]}")

    if user
      @log.debug "User->id:#{user.id}"
      @log.debug "User->username:#{user.username}"
      @log.debug "User->photos.count : #{user.photos.count}"

      @log.info "Getting sets..."
      sets = user.sets
      sets ? loop_sets(sets) : @log.error("Getting sets failed!")
    else
      @log.error "User not found : #{@keys[:username]}"
    end
  end


private

  def load_keys(file)
    # should find "api:", "username:"
    @log.debug "Loading keys..."
    keys = {}
    File.foreach(file) do |line|
      name, value = line.split(':')
      keys[name.to_sym] = value.to_s.chomp
    end
    keys
  end

end

