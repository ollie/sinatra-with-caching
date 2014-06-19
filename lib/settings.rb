# Memcachier Addon
ENV['MEMCACHE_SERVERS']  = ENV['MEMCACHIER_SERVERS']
ENV['MEMCACHE_USERNAME'] = ENV['MEMCACHIER_USERNAME']
ENV['MEMCACHE_PASSWORD'] = ENV['MEMCACHIER_PASSWORD']

# Settings storage class.
class Settings
  class << self
    def memcache_servers
      ENV['MEMCACHE_SERVERS'].split(',') if ENV['MEMCACHE_SERVERS']
    end

    def memcache_settings
      {
        username: ENV['MEMCACHE_USERNAME'],
        password: ENV['MEMCACHE_PASSWORD']
      }
    end

    def cache
      @cache ||= Cache.new(
        Settings.memcache_servers,
        Settings.memcache_settings
      )
    end
  end
end
