require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra'
require 'sinatra/r18n'
require 'redcarpet'
require File.join(File.dirname(__FILE__),'/lib/keventer_reader')
require File.join(File.dirname(__FILE__),'/lib/dt_helper')

KEVENTER_EVENTS_URI = "http://keventer.herokuapp.com/api/events.xml"

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  @@keventer_reader = KeventerReader.new( KEVENTER_EVENTS_URI )
end

before do
  session[:locale] = 'es'
  @page_title = "Kleer - Agile Coaching & Training"
  @markdown_renderer = Redcarpet::Markdown.new(
                            Redcarpet::Render::HTML.new(:hard_wrap => true), 
                            :autolink => true )
end

get '/' do
	@active_tab_index = "active"
	@dt_events_array =  DTHelper::to_dt_event_array(@@keventer_reader.events_for_two_months)

	erb :index
end

get '/entrenamos' do
	@active_tab_entrenamos = "active"
	@page_title += " | Entrenamos"
	@dt_events_array =  DTHelper::to_dt_event_array(@@keventer_reader.events, false)

	erb :entrenamos
end

get '/e-books' do
	@active_tab_ebooks = "active"
	@page_title += " | Publicamos"

	erb :ebooks
end

get '/entrenamos/evento/:event_id_with_name' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  @event = @@keventer_reader.event( event_id, true )
  
  @page_title = "Kleer - " + @event.friendly_title
  
  erb :event
end

get '/entrenamos/evento/:event_id/remote' do
  @event = @@keventer_reader.event( params[:event_id] )

  erb :event_remote, :layout => :layout_empty
end
