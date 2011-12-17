require File.expand_path("../../config/environment", __FILE__)
require 'rubygems'
require 'sinatra'
require 'redis_connection'
require 'haml'
require 'logger'
require 'url_shortner'

$redis = RedisConnection.connect

configure do
  Log = Logger.new("sinatra.log")
  Log.level  = Logger::INFO
  set :views, "#{File.dirname(__FILE__)}/../views"
  set :public_folder, File.dirname(__FILE__) + '/../public'
end

get '/' do
  redirect("/s")
end

get '/s' do
  haml :home, :locals => { :url => params[:url] }
end

get '/:short_code' do
  url = $redis.get("s.bopia.com:#{params[:short_code]}")
  if url.nil?
    redirect('http://bopia.com')
  else
    dest = url =~ /(^|[^\/])(www\.[^\s@]+(\b|$))/i ? "http://#{url}" : url
    $redis.incr("s.bopia.com:#{params[:short_code]}:hits")
    redirect(dest)
  end
end

post '/short' do
  url = UrlShortner.new
  input_url = params[:url]

  if input_url.include?("http://www.amazon.com/") && (input_url.include?("/dp/") || input_url.include?("/gp/"))
    amazon_code = input_url.match(/amazon.com\/.*\/(B0[^\/]+)/)[1]
    input_url = "http://www.amazon.com/dp/#{amazon_code}/?tag=brunmira-20"
    short_code = amazon_code
  else
    short_code = url.short_code
  end

  $redis.set("s.bopia.com:#{short_code}", input_url)
  haml :post, :locals => { :short_code => short_code }
end
