source 'https://rubygems.org'
ruby "1.9.3"
if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

gem 'sinatra'
gem 'thin'
gem 'libxml-ruby'
gem 'sinatra-r18n'
gem 'redcarpet'
gem 'sinatra-flash'
gem 'oauth'
gem 'json'
gem 'i18n'
gem 'prawn'
gem 'curb'
gem 'tzinfo'
gem 'tzinfo-data'
gem 'money'
gem 'escape_utils'

group :development do
  gem 'foreman'
  gem 'heroku'
end

group :development, :test do
  gem 'rspec'
  gem 'cucumber'
  gem 'webrat'
  gem 'simplecov', '~> 0.7.1'
  gem 'coveralls', require: false
end
