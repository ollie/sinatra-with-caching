# Sinatra With Caching

Heroku addons:

* https://devcenter.heroku.com/articles/memcachier
* https://devcenter.heroku.com/articles/memcachedcloud

## Cache Gelpers

Set `cache_control` to `:public`, `:max_age` to `duration` and
take `Accept-Encoding` into account.
Also make sure to `use Rack::Cache` to have effect.

    get '/tweets' do
      cache_response 15
      json 200, Tweet.dataset.each_as(:timeline)
    end

Cache a part of response. If the key exists, returns value
right away, otherwise runs the block and saves it under the key.

    get '/tweets' do
      user = User.first!(id: params[:id])

      tweets = cache_fragment("feed-for-#{ user.id }") do
        user.tweets.each_as(:timeline)
      end

      json 200, tweets
    end

To set explicit expiry to 15 seconds:

    get '/tweets' do
      user = User.first!(id: params[:id])

      tweets = cache_fragment("feed-for-#{ user.id }", 15) do
        user.tweets.each_as(:timeline)
      end

      json 200, tweets
    end

Expire a cached fragment.

    get '/tweets/renew' do
      user = User.first!(id: params[:id])
      # Update tweets
      expire_fragment "feed-for-#{ user.id }"
    end

## Cache (Dalli) itself

Proxy to Dalli (Memcached).

    c = Cache.new

Set items with default expiry (forever or from global options)

    c.set('a', 'lorem')
    c.set('b', 'ipsum')
    c.set('c', 'dolor')

Set items with explicit expiry in seconds

    c.set('d', 'lorem', 5)
    c.set('e', 'ipsum', 10)
    c.set('f', 'dolor', 15)

Get single item

    c.get('a') # => "lorem"
    c.get('b') # => "ipsum"
    c.get('c') # => "dolor"

Get multiple items back in a Hash

    c.get_multi('a', 'b', 'c') # => {"a"=>1, "b"=>2, "c"=>3}
    c.get_multi('a', 'b', 'c') do |key, value|
      puts "#{ key } => #{ value }"
    end

Delete item

    c.delete('a')          # => true
    c.expire_fragment('a') # => true

"Get or set and get", if key does not exist, store the value from the block,
otherwise return the value directly (not entering block twice)

    c.fetch('x') do
      'lorem'
    end # => "lorem"

    c.set('x', 'ipsum')
    c.get('x') # => "ipsum"

    c.fetch('x') do
      'ipsum'
    end # => "ipsum"

    c.cache_fragment('x') do
      'ipsum'
    end # => "ipsum"

With expiry

    c.fetch('a', 5) do
      'lorem'
    end # => "lorem"

    c.cache_fragment('a', 5) do
      'lorem'
    end # => "lorem"

Expire all items (does not do any cleaning)

    c.set('a', 'lorem')
    c.get('a') # => "lorem"
    c.flush
    c.get('a') # => nil

Stats

    c.stats
