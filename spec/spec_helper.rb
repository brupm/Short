ENV["RACK_ENV"] ||= 'test'
require 'rspec'
require 'webmock/rspec'

require File.expand_path("../../config/environment", __FILE__)
require 'redis_connection'

RSpec.configure do |config|

  config.before(:each) do
    $redis = RedisConnection.connect
    $redis.flushdb
  end

end
