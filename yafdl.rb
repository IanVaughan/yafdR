require 'fleakr'  #https://github.com/reagent/fleakr

class yafdl

  def initialize(file)
    @log = Logger.new('log.txt')
    @keys = load_keys(file) if File.exists(file)
    Fleakr.api_key = "#{keys[:api]}"  #Fleakr.api_key = '304ae3719ef4fb2c91557c5e553f1e9c'
  end


private

  def load_keys(file)
    @log.debug "Loading keys..."
    keys = {}
    File.foreach(file) do |line|
      name, value = line.split(':')
      keys[name.to_sym] = value.to_s
    end
    keys
  end



end

