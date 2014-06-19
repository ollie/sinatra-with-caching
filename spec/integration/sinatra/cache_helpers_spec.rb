require 'spec_helper_integration'

RSpec.describe Sinatra::CacheHelpers do
  context 'cache_response' do
    before do
      App.get '/test/helper/cache/cache-response' do
        cache_response 2.seconds
        sleep 0.5
        'Hello World'
      end
    end

    it 'caches it' do
      duration = timed_get('/test/helper/cache/cache-response')
      expect(last_status).to eq(200)
      expect(duration).to be_within(0.1).of(0.5)

      duration = timed_get('/test/helper/cache/cache-response')
      expect(last_status).to eq(200)
      expect(duration).to be_within(0.01).of(0)
    end
  end

  context 'cache_fragment' do
    before do
      App.get '/test/helper/cache/cache-fragment' do
        cache_fragment('test-fragment') do
          sleep 0.5
          'Hello World'
        end
      end
    end

    it 'caches it' do
      Settings.cache.expire_fragment('test-fragment')

      duration = timed_get('/test/helper/cache/cache-fragment')
      expect(last_status).to eq(200)
      expect(duration).to be_within(0.1).of(0.5)

      duration = timed_get('/test/helper/cache/cache-fragment')
      expect(last_status).to eq(200)
      expect(duration).to be_within(0.1).of(0)
    end
  end

  context 'expire_fragment' do
    before do
      App.get '/test/helper/cache/expire-fragment' do
        cache_fragment('test-fragment') do
          sleep 0.5
          'Hello World'
        end

        expire_fragment('test-fragment')
      end
    end

    it 'expires it' do
      Settings.cache.expire_fragment('test-fragment')

      duration = timed_get('/test/helper/cache/expire-fragment')
      expect(last_status).to eq(200)
      expect(duration).to be_within(0.1).of(0.5)

      duration = timed_get('/test/helper/cache/expire-fragment')
      expect(last_status).to eq(200)
      expect(duration).to be_within(0.1).of(0.5)
    end
  end
end
