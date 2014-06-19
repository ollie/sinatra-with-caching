# Memcachier Addon
ENV['MEMCACHE_SERVERS']  = ENV['MEMCACHIER_SERVERS']
ENV['MEMCACHE_USERNAME'] = ENV['MEMCACHIER_USERNAME']
ENV['MEMCACHE_PASSWORD'] = ENV['MEMCACHIER_PASSWORD']

# Settings storage class.
class Settings
  class << self
    def memcached_servers
      ENV['MEMCACHE_SERVERS'].split(',') if ENV['MEMCACHE_SERVERS']
    end

    def memcached_settings
      {
        username: ENV['MEMCACHE_USERNAME'],
        password: ENV['MEMCACHE_PASSWORD']
      }
    end

    def cache
      @cache ||= Cache.new(
        memcached_servers,
        memcached_settings
      )
    end
  end
end
