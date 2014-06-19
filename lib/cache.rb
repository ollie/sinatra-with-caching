# Proxy to Dalli (Memcached).
#
#   c = Settings.cache
#
# Set items with default expiry (forever or from global options)
#
#   c.set('a', 'lorem')
#   c.set('b', 'ipsum')
#   c.set('c', 'dolor')
#
# Set items with explicit expiry in seconds
#
#   c.set('d', 'lorem', 5)
#   c.set('e', 'ipsum', 10)
#   c.set('f', 'dolor', 15)
#
# Get single item
#
#   c.get('a') # => "lorem"
#   c.get('b') # => "ipsum"
#   c.get('c') # => "dolor"
#
# Get multiple items back in a Hash
#
#   c.get_multi('a', 'b', 'c') # => {"a"=>1, "b"=>2, "c"=>3}
#   c.get_multi('a', 'b', 'c') do |key, value|
#     puts "#{ key } => #{ value }"
#   end
#
# Delete item
#
#   c.delete('a')          # => true
#   c.expire_fragment('a') # => true
#
# "Get or set and get", if key does not exist, store the value from the block,
# otherwise return the value directly (not entering block twice)
#
#   c.fetch('x') do
#     'lorem'
#   end # => "lorem"
#
#   c.set('x', 'ipsum')
#   c.get('x') # => "ipsum"
#
#   c.fetch('x') do
#     'ipsum'
#   end # => "ipsum"
#
#   c.cache_fragment('x') do
#     'ipsum'
#   end # => "ipsum"
#
# With expiry
#
#   c.fetch('a', 5) do
#     'lorem'
#   end # => "lorem"
#
#   c.cache_fragment('a', 5) do
#     'lorem'
#   end # => "lorem"
#
# Expire all items (does not do any cleaning)
#
#   c.set('a', 'lorem')
#   c.get('a') # => "lorem"
#   c.flush
#   c.get('a') # => nil
#
# Stats
#
#   c.stats
class Cache
  attr_accessor :client

  def initialize(*args)
    Dalli::Client.send(:alias_method, :cache_fragment, :fetch)
    Dalli::Client.send(:alias_method, :expire_fragment, :delete)
    self.client = Dalli::Client.new(*args)
  end

  # Proxy other methods to Dalli client if it knows them, also define them here.
  def method_missing(meth, *args, &block)
    super unless client.respond_to?(meth)

    define_singleton_method meth do |*meth_args, &meth_block|
      client.send(meth, *meth_args, &meth_block)
    end

    send(meth, *args, &block)
  end
end
