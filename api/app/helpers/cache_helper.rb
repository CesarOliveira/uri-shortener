module CacheHelper
  extend self

  def connected?
    ping unless Rails.cache.redis.connected?

    true
  end

  def ping
    Rails.cache.redis.ping
  rescue StandardError
    false
  end

  def fetch(key, expires_in, &block)
    block.call unless connected?

    Rails.cache.fetch(key, expires_in: expires_in) { block.call }
  end
end
