# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra'
require 'sinatra/r18n'
require 'sinatra/flash'
require 'redcarpet'
require 'json'
require File.join(File.dirname(__FILE__),'/lib/keventer_reader')
require File.join(File.dirname(__FILE__),'/lib/dt_helper')

KEVENTER_EVENTS_URI = "http://keventer.herokuapp.com/api/events.xml"
KEVENTER_COMUNITY_EVENTS_URI = "http://keventer.herokuapp.com/api/community_events.xml"

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  enable :sessions
  @@keventer_reader = KeventerReader.new(KEVENTER_EVENTS_URI)
  @@keventer_reader_community = KeventerReader.new(KEVENTER_COMUNITY_EVENTS_URI)
end

before do
  session[:locale] = 'es'
  @page_title = "Kleer - Agile Coaching & Training"
  flash.sweep 
  @markdown_renderer = Redcarpet::Markdown.new(
                            Redcarpet::Render::HTML.new(:hard_wrap => true), 
                            :autolink => true)
end

not_found do
  @page_title = "404 - No encontrado"
  
  if !request.path.index("/entrenamos/introduccion-a-scrum").nil?
    flash.now[:error] = get_404_error_text_for_course("Introducción a Scrum")
    erb :error404_to_calendar
  elsif !request.path.index("/entrenamos/desarrollo-agil-de-software").nil?
      flash.now[:error] = get_404_error_text_for_course("Desarrollo Ágil de Software")
      erb :error404_to_calendar
  elsif !request.path.index("/entrenamos/estimacion-y-planificacion-con-scrum").nil?
      flash.now[:error] = get_404_error_text_for_course("Análisis, Estimación y Planificación con Scrum")
      erb :error404_to_calendar
  elsif !request.path.index("/comunidad/yoseki").nil?
      flash.now[:error] = get_404_error_text_for_community_event("Yoseki Coding Dojo")
      erb :error404_to_community
  else
    erb :error404
  end
end

get '/' do
	@active_tab_index = "active"

	erb :index
end

get '/es/:path' do
  redirect "/" + params[:path]
end

get '/entrenamos' do
 	@active_tab_entrenamos = "active"
	@page_title += " | Entrenamos"
  @unique_countries = @@keventer_reader.unique_countries()
	erb :entrenamos
end

get '/comunidad' do
 	@active_tab_comunidad = "active"
	@page_title += " | Comunidad"
	@unique_countries = @@keventer_reader_community.unique_countries()
	erb :comunidad
end

get '/e-books' do
	@active_tab_ebooks = "active"
	@page_title += " | Publicamos"

	erb :ebooks
end

get '/acompanamos' do
  @active_tab_acompanamos = "active"
	@page_title += " | Acompañamos"

	erb :acompanamos
end

get '/entrenamos/evento/:event_id_with_name' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  @event = @@keventer_reader.event(event_id, true)
  
  @active_tab_entrenamos = "active"
  @page_title = "Kleer - " + @event.friendly_title
  
  erb :event
end

get '/entrenamos/evento/:event_id_with_name/remote' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  @event = @@keventer_reader.event(event_id, false)
  puts @event.trainer_name
  erb :event_remote, :layout => :layout_empty
end

get '/comunidad/evento/:event_id_with_name' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  @event = @@keventer_reader_community.event(event_id, true)
  
  puts @event
  
  @active_tab_comunidad = "active"
  @page_title = "Kleer - " + @event.friendly_title
  
  erb :event
end

get '/entrenamos/eventos/proximos' do
  content_type :json
  DTHelper::to_dt_event_array_json(@@keventer_reader.coming_events(), true, "entrenamos")
end

get '/entrenamos/eventos/pais/:country_iso_code' do
  content_type :json
  country_iso_code = params[:country_iso_code]
  DTHelper::to_dt_event_array_json(@@keventer_reader.events_by_country(country_iso_code), false, "entrenamos")
end

get '/comunidad/eventos/pais/:country_iso_code' do
  content_type :json
  country_iso_code = params[:country_iso_code]
  DTHelper::to_dt_event_array_json(@@keventer_reader_community.events_by_country(country_iso_code), false, "comunidad")
end

private

def get_404_error_text_for_course(course_name) 
  "Hemos movido la información sobre el curso '<strong>#{course_name}</strong>'. Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
end

def get_404_error_text_for_community_event(event_name) 
  "Hemos movido la información sobre el evento comunitario '<strong>#{event_name}</strong>'. Por favor, verifica nuestro calendario para ver los detalles de dicho evento"
end