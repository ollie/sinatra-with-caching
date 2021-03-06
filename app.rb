# Dummy app.
class App < Sinatra::Base
  use Rack::Cache, metastore:   Settings.cache.client,
                   entitystore: Settings.cache.client

  helpers Sinatra::CacheHelpers

  get '/' do
    cache_response 2.seconds
    sleep 0.5
    'Hello'
  end

  get '/fragment' do
    cache_fragment('test-1') do
      sleep 0.5
      'Hello'
    end
  end

  get '/expire' do
    expire_fragment('test-1')
  end

  get '/fragment-timed' do
    cache_fragment('test-2', 5) do
      sleep 0.5
      'Hello'
    end
  end
end
