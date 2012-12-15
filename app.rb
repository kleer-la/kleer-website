require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra'
configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

get '/' do
	@active_tab_index = "active"
	erb :index
end

get '/e-books' do
	@active_tab_ebooks = "active"
	erb :ebooks
end
