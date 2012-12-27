require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra'
require File.join(File.dirname(__FILE__),'/lib/keventer_reader')
require File.join(File.dirname(__FILE__),'/lib/dt_helper')

KEVENTER_EVENTS_URI = "http://keventer.herokuapp.com/api/events.xml"

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  @@keventer_reader = KeventerReader.new( KEVENTER_EVENTS_URI )
end

get '/' do
	@active_tab_index = "active"
	@dt_events_array =  DTHelper::to_dt_event_array(@@keventer_reader.events_for_two_months)
	erb :index
end

get '/entrenamos' do
	@active_tab_entrenamos = "active"
	@dt_events_array =  DTHelper::to_dt_event_array(@@keventer_reader.events)
	erb :entrenamos
end

get '/e-books' do
	@active_tab_ebooks = "active"
	erb :ebooks
end
