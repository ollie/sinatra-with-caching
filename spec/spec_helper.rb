ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

# Coverage tool, needs to be started as soon as possible
SimpleCov.start do
  # Ignore spec directory
  add_filter '/spec/'
  add_filter '/lib/settings.rb'
end

require './lib/settings.rb'
require './lib/extensions/fixnum.rb'
require './lib/cache.rb'

RSpec.configure do |config|
  config.disable_monkey_patching!
end
