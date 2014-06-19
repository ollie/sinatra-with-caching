require 'spec_helper'

RSpec.describe Fixnum do
  it 'seconds' do
    expect(5.seconds).to eq(5)
  end

  it 'second' do
    expect(5.second).to eq(5)
  end

  it 'minutes' do
    expect(5.minutes).to eq(300)
  end

  it 'minute' do
    expect(5.minute).to eq(300)
  end

  it 'hours' do
    expect(5.hours).to eq(18_000)
  end

  it 'hour' do
    expect(5.hour).to eq(18_000)
  end

  it 'days' do
    expect(5.days).to eq(432_000)
  end

  it 'day' do
    expect(5.day).to eq(432_000)
  end

  it 'ago' do
    now   = Time.now
    other = 5.days.ago

    expect(other).to be_within(100).of(now - 5.days)
  end

  it 'from_now' do
    now   = Time.now
    other = 5.days.from_now

    expect(other).to be_within(100).of(now + 5.days)
  end
end
