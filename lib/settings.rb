# Settings storage class.
class Settings
  class << self
    def development?
      ENV['RACK_ENV'] == 'development'
    end

    def test?
      ENV['RACK_ENV'] == 'test'
    end

    def prodction?
      ENV['RACK_ENV'] == 'prodction'
    end

    def rack_cache_metastore_url
      'memcached://127.0.0.1:11211/meta'
    end

    def rack_cache_entitystore_url
      'memcached://127.0.0.1:11211/body'
    end

    def memcache_servers
      if prodction?
        (ENV['MEMCACHE_SERVERS'] || '').split(',')
      else
        'memcached://127.0.0.1:11211/dalli'
      end
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
