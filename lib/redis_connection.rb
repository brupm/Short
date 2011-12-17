require 'em-hiredis'
require 'redis'
class RedisConnection
  def self.async
    RedisConnection.new.async
  end

  def self.connect
    RedisConnection.new.connect
  end

  def async
    puts "Async Redis: #{url}"
    EM::Hiredis.connect url
  end

  def connect
    puts "Sync Redis: #{url}"
    Redis.new config
  end

  def threaded

  end

  def config
    uri = URI.parse(url)
    options = {:host => uri.host, :port => uri.port}
    options[:password] = uri.password if uri.password
    options[:db] = uri.path.split('/').last.to_i if uri.path && uri.path.length > 1
    options
  end

  def url
    ENV['REDISTOGO_URL'] || "redis://127.0.0.1:6379/#{ENV['RACK_ENV'] == 'test' ? 11 : 10}"
  end

end
