require 'spec_helper_integration'

RSpec.describe App do
  it '/' do
    duration = timed_get('/')
    expect(last_status).to eq(200)
    expect(duration).to be_within(0.1).of(0.5)

    duration = timed_get('/')
    expect(last_status).to eq(200)
    expect(duration).to be_within(0.01).of(0)
  end

  it '/fragment' do
    Settings.cache.expire_fragment('test-1')

    duration = timed_get('/fragment')
    expect(last_status).to eq(200)
    expect(duration).to be_within(0.1).of(0.5)
  end

  it '/expire' do
    get '/expire'
    expect(last_status).to eq(200)
  end

  it '/fragment-timed' do
    Settings.cache.expire_fragment('test-2')

    duration = timed_get('/fragment-timed')
    expect(last_status).to eq(200)
    expect(duration).to be_within(0.1).of(0.5)
  end
end
