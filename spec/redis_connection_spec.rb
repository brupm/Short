require 'spec_helper'
require 'redis_connection'

describe RedisConnection do

  describe 'connection' do
    it "should connect asynchronously" do
      EM.run do
        redis = RedisConnection.async
        redis.set("test",1).callback do
          redis.get('test').callback do |r|
            EM.stop_event_loop
            r.should == '1'
          end
        end
      end
    end

    it "should connect synchronously" do
      redis = RedisConnection.connect
      redis.set("test",1)
      redis.get('test').should == '1'
    end

  end

  describe "configuration" do
    it "should have default test config" do
      RedisConnection.new.url.should == 'redis://127.0.0.1:6379/11'
      RedisConnection.new.config.should == {:host => '127.0.0.1', :port => 6379, :db => 11}
    end

    it "should have default development config" do
      ENV["RACK_ENV"] = 'development'

      RedisConnection.new.url.should == 'redis://127.0.0.1:6379/10'
      RedisConnection.new.config.should == {:host => '127.0.0.1', :port => 6379, :db => 10}

      ENV["RACK_ENV"] = 'test'
    end

    it "should have DATABASE_URL config" do
      ENV["REDISTOGO_URL"] = 'redis://redistogo:password@carp.redistogo.com:9028/'

      RedisConnection.new.url.should == 'redis://redistogo:password@carp.redistogo.com:9028/'
      RedisConnection.new.config.should == {:host => 'carp.redistogo.com', :port => 9028, :password => 'password'}

      ENV["REDISTOGO_URL"] = nil
    end

  end
end
