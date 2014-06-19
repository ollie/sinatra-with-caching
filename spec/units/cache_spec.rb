require 'spec_helper'

RSpec.describe Cache do
  subject { Settings.cache }

  it 'sets and gets' do
    expect(subject.set('a', 'lorem')).to be_a(Numeric)
    expect(subject.get('a')).to eq('lorem')
  end

  it 'deletes' do
    subject.set('a', 'lorem')
    expect(subject.delete('a')).to eq(true)
  end

  it 'cache_fragment' do
    subject.delete('a')
    expect(
      subject.cache_fragment('a') do
        'lorem'
      end
    ).to eq('lorem')
  end

  it 'cache_fragment' do
    subject.set('a', 'lorem')
    expect(subject.expire_fragment('a')).to eq(true)
  end
end
