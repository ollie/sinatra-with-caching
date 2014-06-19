ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

require './lib/settings.rb'
require './lib/extensions/fixnum.rb'
require './lib/cache.rb'

require './lib/sinatra/cache_helpers.rb'
require './app.rb'

run App
