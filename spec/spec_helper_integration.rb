require 'spec_helper'
require 'benchmark'

require './lib/sinatra/cache_helpers.rb'
require './app.rb'

APP = Rack::Builder.parse_file('config.ru').first

# Methods in this module will be available in the tests.
module RSpecMixin
  include Rack::Test::Methods

  def app
    APP
  end

  def last_status
    last_response.status
  end

  def map_and_call(path, params = {}, rack_env = {}, &block)
    RssApp.get path, &block
    get path, params, rack_env
  end

  def timed_get(*args)
    duration = Benchmark.realtime do
      get(*args)
    end
    puts "-> #{ duration }s"
    duration
  end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
