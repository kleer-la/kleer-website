# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra'
require 'sinatra/r18n'
require 'sinatra/flash'
require 'redcarpet'
require 'json'
require File.join(File.dirname(__FILE__),'/lib/keventer_reader')
require File.join(File.dirname(__FILE__),'/lib/dt_helper')
require File.join(File.dirname(__FILE__),'/lib/twitter_card')
require File.join(File.dirname(__FILE__),'/lib/event_type')
require File.join(File.dirname(__FILE__),'/lib/twitter_reader')

configure do
  set :views, "#{File.dirname(__FILE__)}/views"
  enable :sessions
  @@keventer_reader = KeventerReader.new
end

before do
  if request.host == "kleer.la"
    redirect "http://www." + request.host + request.path
  else
    session[:locale] = 'es'
    @page_title = "Kleer - Agile Coaching & Training"
    flash.sweep 
    @markdown_renderer = Redcarpet::Markdown.new(
                              Redcarpet::Render::HTML.new(:hard_wrap => true), 
                              :autolink => true)
  end
end

get '/' do
	@active_tab_index = "active"
	@categories = @@keventer_reader.categories
	erb :index
end

get '/blog' do
  @active_tab_blog = "active"
  erb :blog
end

get '/entrenamos' do
 	@active_tab_entrenamos = "active"
	@page_title += " | Entrenamos"
  @unique_countries = @@keventer_reader.unique_countries_for_commercial_events()
	erb :entrenamos
end

get '/acompanamos' do
  @active_tab_acompanamos = "active"
	@page_title += " | Acompañamos"
	erb :acompanamos
end

get '/comunidad' do
  @active_tab_comunidad = "active"
  @page_title += " | Comunidad"
  @unique_countries = @@keventer_reader.unique_countries_for_community_events()
  erb :comunidad
end

get '/e-books' do
  redirect "/publicamos", 301 # permanent redirect
end

get '/publicamos' do
  @active_tab_publicamos = "active"
  @page_title += " | Publicamos"
  erb :ebooks
end

get '/categoria/:category_codename' do
  @category = @@keventer_reader.category(params[:category_codename])

  if @category.nil?
    status 404
  else
    @page_title += " | " + @category.name
    @event_types = @category.event_types

    erb :category
  end
end

get '/entrenamos/evento/:event_id_with_name' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  if is_valid_id(event_id)
    @event = @@keventer_reader.event(event_id, true)
  end
  
  if @event.nil?
    flash.now[:error] = get_course_not_found_error()
    erb :error404_to_calendar
  else
    @active_tab_entrenamos = "active"
    @twitter_card = create_twitter_card( @event )    
    @page_title = "Kleer - " + @event.friendly_title
    erb :event
  end
end

get '/cursos/:event_type_id_with_name' do
  event_type_id_with_name = params[:event_type_id_with_name]
  event_type_id = event_type_id_with_name.split('-')[0]
  if is_valid_id(event_type_id)
    @event = @@keventer_reader.event_type(event_type_id, true)
  end
  
  #if @event.nil?
  #  flash.now[:error] = get_course_not_found_error()
  #  erb :error404_to_calendar
  #else
  #  @active_tab_entrenamos = "active"
  #  @twitter_card = create_twitter_card( @event )    
  #  @page_title = "Kleer - " + @event.friendly_title
  #  erb :event
  #end
  erb :event_type
end

get '/entrenamos/evento/:event_id_with_name/entrenador/remote' do
  event_id_with_name = params[:event_id_with_name]

  event_id = event_id_with_name.split('-')[0]
  if is_valid_id(event_id)
    @event = @@keventer_reader.event(event_id, false)
  end

  if @event.nil?
    @error = get_course_not_found_error()
    erb :error404_remote_to_calendar, :layout => :layout_empty
  else
    erb :trainer_remote, :layout => :layout_empty
  end
end

get '/entrenamos/evento/:event_id_with_name/remote' do
  event_id_with_name = params[:event_id_with_name]

  event_id = event_id_with_name.split('-')[0]
  if is_valid_id(event_id)
    @event = @@keventer_reader.event(event_id, false)
  end

  if @event.nil?
    @error = get_course_not_found_error()
    erb :error404_remote_to_calendar, :layout => :layout_empty
  else
    erb :event_remote, :layout => :layout_empty
  end
end

get '/entrenamos/evento/:event_id_with_name/registration' do
  event_id_with_name = params[:event_id_with_name]

  event_id = event_id_with_name.split('-')[0]
  if is_valid_id(event_id)
    @event = @@keventer_reader.event(event_id, false)
  end

  puts @event.nil?

  if @event.nil?
    @error = get_course_not_found_error()
    erb :error404_remote_to_calendar, :layout => :layout_empty
  else
    erb :event_remote_registration, :layout => :layout_empty
  end
end

get '/comunidad/evento/:event_id_with_name' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  if is_valid_id(event_id)
    @event = @@keventer_reader.event(event_id, true)
  end

  if @event.nil?
    flash.now[:error] = get_community_event_not_found_error()
    erb :error404_to_community
  else
    @active_tab_comunidad = "active"
    @twitter_card = create_twitter_card( @event )
    @page_title = "Kleer - " + @event.friendly_title
    erb :event
  end
end

get '/somos' do
 	@active_tab_somos = "active"
	@page_title += " | Somos"
	@kleerers = @@keventer_reader.kleerers
	erb :somos
end

get '/last-tweet/:screen_name' do
  reader = TwitterReader.new
  return reader.last_tweet(params[:screen_name]).text
end

# JSON ==================== 

get '/entrenamos/eventos/proximos' do
  content_type :json
  DTHelper::to_dt_event_array_json(@@keventer_reader.coming_commercial_events(), true, "entrenamos")
end

get '/entrenamos/eventos/proximos/:amount' do
  content_type :json
  amount = params[:amount]
  if !amount.nil?
    amount = amount.to_i
  end
  DTHelper::to_dt_event_array_json(@@keventer_reader.coming_commercial_events(), true, "entrenamos", amount)
end

get '/entrenamos/eventos/pais/:country_iso_code' do
  content_type :json
  country_iso_code = params[:country_iso_code]
  if (!is_valid_country_iso_code(country_iso_code, "entrenamos"))
    country_iso_code = "todos"
  end
  DTHelper::to_dt_event_array_json(@@keventer_reader.commercial_events_by_country(country_iso_code), false, "entrenamos")
end

get '/comunidad/eventos/pais/:country_iso_code' do
  content_type :json
  country_iso_code = params[:country_iso_code]
  if (!is_valid_country_iso_code(country_iso_code, "comunidad"))
    country_iso_code = "todos"
  end
  DTHelper::to_dt_event_array_json(@@keventer_reader.community_events_by_country(country_iso_code), false, "comunidad")
end

# STATIC FILES ============== 

get '/preguntas-frecuentes/facturacion-pagos-internacionales' do
  erb :facturacion_pagos_internacionales
end

get '/preguntas-frecuentes/certified-scrum-master' do
  erb :certified_scrum_master
end

get '/preguntas-frecuentes/certified-scrum-developer' do
  erb :certified_scrum_developer
end

get '/sepyme' do
  erb :sepyme
end

get '/sepyme/remote' do
  erb :sepyme_remote, :layout => :layout_empty
end

# LEGACY ==================== 

get '/es/:path' do
  redirect "/" + params[:path]
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

private

def create_twitter_card( event )
  card = TwitterCard.new
  card.title = event.friendly_title
  card.description = event.event_type.elevator_pitch
  card.image_url = "http://media.kleer.la/logos/K_social.jpg"
  card.site = "@kleer_la"
  card.creator = event.trainer.twitter_username
  card
end

def get_404_error_text_for_course(course_name) 
  "Hemos movido la información sobre el curso '<strong>#{course_name}</strong>'. Por favor, verifica nuestro calendario para ver los detalles de dicho curso"
end

def get_404_error_text_for_community_event(event_name) 
  "Hemos movido la información sobre el evento comunitario '<strong>#{event_name}</strong>'. Por favor, verifica nuestro calendario para ver los detalles de dicho evento"
end

def get_course_not_found_error
  "El curso que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado.<br/>Te invitamos a visitar nuestro calendario para ver los cursos vigentes y probables nuevas fechas para el curso que estás buscando."
end

def get_community_event_not_found_error
  "El evento comunitario que estás buscando no fue encontrado. Es probable que ya haya ocurrido o haya sido cancelado.<br/>Te invitamos a visitar nuestro calendario para ver los eventos vigentes y probables nuevas fechas para el evento que estás buscando."
end

def is_valid_id(event_id_to_test)
  !(event_id_to_test.match(/^[0-9]+$/).nil?)
end

def is_valid_country_iso_code(country_iso_code_to_test, event_type)
  return true if (country_iso_code_to_test == "otro" or country_iso_code_to_test == "todos")

  if event_type == "entrenamos"
    unique_countries = @@keventer_reader.unique_countries_for_commercial_events()
  else
    unique_countries = @@keventer_reader.unique_countries_for_community_events()
  end
  unique_countries.each { |country|
    if (country.iso_code == country_iso_code_to_test)
      return true
    end
  }

  return false
end
