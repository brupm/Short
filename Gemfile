source 'http://rubygems.org'

gem 'rake'
gem 'sinatra'
gem 'haml'
gem 'rack-ssl', :require => 'rack/ssl'
gem 'redis'

gem 'eventmachine', '~> 1.0.0.beta.4'
gem 'em-hiredis', '~> 0.1.0'
gem 'em-http-request', '~> 1.0'
gem 'thin'

group :development do
  gem 'heroku', '~> 2.4.1'
  gem 'foreman'
  gem 'shotgun'
end

group :test do
  gem 'rspec'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'rcov', '~> 0.9.9'
  gem 'webmock'
  gem 'growl_notify'
end

group :production do
  gem 'newrelic_rpm', '~> 3.1.0'
end
