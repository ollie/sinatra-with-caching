ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

require './lib/settings'
require 'benchmark'

def fixnum
  require './lib/extensions/fixnum.rb'

  Benchmark.bm do |x|
    x.report do
      1_000_000.times { 5.days }
      1_000_000.times { 5.day }
      1_000_000.times { 5.hours }
      1_000_000.times { 5.hour }
      1_000_000.times { 5.minutes }
      1_000_000.times { 5.minute }
      1_000_000.times { 5.seconds }
      1_000_000.times { 5.seconds }
    end
  end
end

def memcached
  require './lib/data.rb'

  data = Data.list
  d = Dalli::Client.new(Settings.memcache_servers)

  Benchmark.bm do |x|
    x.report do
      1_000.times do
        data.each do |i|
          d.set i[:id], i
        end
      end
    end
  end
end

fixnum
memcached
