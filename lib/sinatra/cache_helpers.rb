module Sinatra
  # Helpers for caching with Rack::Cache and fragment caching with Memcached.
  module CacheHelpers
    # Set +cache_control+ to +:public+, +:max_age+ to +duration+ and
    # take +Accept-Encoding+ into account.
    # Also make sure to <code>use Rack::Cache</code> to have effect.
    #
    #   get '/tweets' do
    #     cache_response 15
    #     json 200, Tweet.dataset.each_as(:timeline)
    #   end
    #
    # @param duration [Fixnum] Amount of seconds the page should be cached for.
    def cache_response(duration)
      cache_control :public, max_age: duration,
                             vary:    'Accept-Encoding'
    end

    # Cache a part of response. If the key exists, returns value
    # right away, otherwise runs the block and saves it under the key.
    #
    #   get '/tweets' do
    #     user = User.first!(id: params[:id])
    #
    #     tweets = cache_fragment("feed-for-#{ user.id }") do
    #       user.tweets.each_as(:timeline)
    #     end
    #
    #     json 200, tweets
    #   end
    #
    # To set explicit expiry to 15 seconds:
    #
    #   get '/tweets' do
    #     user = User.first!(id: params[:id])
    #
    #     tweets = cache_fragment("feed-for-#{ user.id }", 15) do
    #       user.tweets.each_as(:timeline)
    #     end
    #
    #     json 200, tweets
    #   end
    #
    def cache_fragment(key, duration = nil, &block)
      Settings.cache.cache_fragment(key, duration, &block)
    end

    # Expire a cached fragment.
    #
    #   get '/tweets/renew' do
    #     user = User.first!(id: params[:id])
    #     # Update tweets
    #     expire_fragment "feed-for-#{ user.id }"
    #   end
    #
    def expire_fragment(key)
      Settings.cache.expire_fragment(key)
    end
  end
end
