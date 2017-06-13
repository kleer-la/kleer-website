# encoding: utf-8
require 'rubygems' if RUBY_VERSION < '1.9'
require 'sinatra'
require 'sinatra/r18n'
require 'sinatra/flash'
require 'redcarpet'
require 'json'
require 'i18n'
require 'money'
require 'rss'
require 'escape_utils'

require File.join(File.dirname(__FILE__),'/lib/keventer_reader')
require File.join(File.dirname(__FILE__),'/lib/dt_helper')
require File.join(File.dirname(__FILE__),'/lib/twitter_card')
require File.join(File.dirname(__FILE__),'/lib/twitter_reader')
require File.join(File.dirname(__FILE__),'/lib/pdf_catalog')
require File.join(File.dirname(__FILE__),'/lib/crm_connector')
require File.join(File.dirname(__FILE__),'/lib/toggle')

helpers do

  MONTHS_ES = { "Jan" => "Ene", "Feb" => "Feb", "Mar" => "Mar", "Apr" => "Abr", "May" => "May", "Jun" => "Jun",
                "Jul" => "Jul", "Aug" => "Ago", "Sep" => "Sep", "Oct" => "Oct", "Nov" => "Nov", "Dec" => "Dic"}

  def month_es(month_en)
    MONTHS_ES[month_en]
  end

  def feature_on?(feature)
    Toggle.on?(feature)
  end

  def t(key, ops = Hash.new)
    ops.merge!(:locale => session[:locale])
    I18n.t key, ops
  end

  def url_sanitize(data)
    sanitized = data;
    sanitized = sanitized.gsub('á', 'a')
    sanitized = sanitized.gsub('é', 'e')
    sanitized = sanitized.gsub('í', 'i')
    sanitized = sanitized.gsub('ó', 'o')
    sanitized = sanitized.gsub('ú', 'u')
    sanitized = sanitized.gsub('Á', 'A')
    sanitized = sanitized.gsub('E', 'E')
    sanitized = sanitized.gsub('Í', 'I')
    sanitized = sanitized.gsub('Ó', 'O')
    sanitized = sanitized.gsub('Ú', 'U')
  end

  def currency_symbol_for( iso_code )
    currency = Money::Currency.table[iso_code.downcase.to_sym] unless iso_code.nil?
    if currency.nil?
      ""
    else
      currency[:symbol]
    end
  end

  def money_format( amount )
      parts = amount.round(0).to_s.split('.')
      parts[0].gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1.")
      parts.join "."
  end
end

configure do
  set :views, "#{File.dirname(__FILE__)}/views"

  I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'locales', '*.yml').to_s]

  enable :sessions
  KeventerReader.build
end

before do

  if request.host.include?( "kleer.us" )
    session[:locale] = 'en'
  else
    session[:locale] = 'es'
  end

  if request.host == "kleer.la" || request.host == "kleer.us" || request.host == "kleer.es" || request.host == "kleer.com.ar"
    redirect "http://www." + request.host + request.path
  else
    @page_title = "Kleer - Agile Coaching & Training"
    flash.sweep
    @markdown_renderer = Redcarpet::Markdown.new(
                              Redcarpet::Render::HTML.new(:hard_wrap => true),
                              :autolink => true)
  end
end

before '/:locale/*' do
  locale = params[:locale]

  if locale == "es" || locale == "en"
    session[:locale] = locale
    request.path_info = '/' + params[:splat ][0]
  else
    session[:locale] = 'es'
  end
end

get '/' do
	@active_tab_index = "active"
	@categories = KeventerReader.instance.categories session[:locale]
	@kleerers = KeventerReader.instance.kleerers session[:locale]
	erb :index
end

get '/en' do
  redirect "/en/", 301 # permanent redirect
end

get '/es' do
  redirect "/es/", 301 # permanent redirect
end

get '/blog' do
  @active_tab_blog = "active"
  @rss = RSS::Parser.parse('http://feed.informer.com/digests/EGSKOZF5FA/feeder.rss', false)

  erb :blog
end

get '/entrenamos/:country?' do |country|
	entrenamos_view(country)
end
get '/entrenamos' do
	entrenamos_view
end

def entrenamos_view(country=nil)
	if !country.nil? && country!='todos' && country.length>2
	    status 404
	else
		@active_tab_entrenamos = "active"
		@page_title += " | Entrenamos"
		@unique_countries = KeventerReader.instance.unique_countries_for_commercial_events()
		@country= country || session[:filter_country] || 'todos'
    session[:filter_country]= @country
    erb :entrenamos
	end
end


get '/acompanamos' do
  redirect "/coaching", 301 # permanent redirect
end

get '/coaching' do
	@active_tab_coaching = "active"
	@page_title += " | Coaching"
	@categories = KeventerReader.instance.categories session[:locale]
	erb :coaching
end

get '/comunidad' do
  @active_tab_comunidad = "active"
  @page_title += " | Comunidad"
  @unique_countries = KeventerReader.instance.unique_countries_for_community_events()
  erb :comunidad
end

get '/live' do
  @active_tab_comunidad = "active"
  redirect "http://live.kleer.la", 301 # permanent redirect
end


get '/e-books' do
  redirect "/publicamos", 301 # permanent redirect
end

get '/facilitacion' do
  @active_tab_facilitacion = "active"
  redirect "http://facilitacion.kleer.la", 301 # permanent redirect
end

get '/publicamos' do
  @active_tab_publicamos = "active"
  @page_title += " | Publicamos"
  erb :ebooks
end

post '/subscribe' do
  @email = params[:email]
  @fname = params[:fname]
  @lname = params[:lname]
  @influence_zone_tag = params[:influence_zone_tag]

  CrmConnector::subscribe_person( @email, @fname, @lname, @influence_zone_tag )

  erb :subscribe
end

get '/publicamos/scrum' do
  @active_tab_publicamos = "active"
  @page_title += " | Publicamos | Proyectos Ágiles con Scrum"
  erb :ebook_scrum_plain, :layout => :layout_ebook_landing
end

get '/mas-productivos' do
  redirect "/publicamos/mas-productivos", 301 # permanent redirect
end

get '/publicamos/mas-productivos' do
  @active_tab_publicamos = "active"
  @page_title += " | Publicamos | Equipos más productivos"
  erb :ebook_masproductivos_plain, :layout => :layout_ebook_landing
end

get '/posters/:poster_code' do
  @poster_code = params[:poster_code]

  case @poster_code
  when "scrum"
    @video_url_code = "IWUG29VPhUA"
    @poster_name = "Scrum"
  when "xp"
    @video_url_code = "4nN6Gh79Yg8"
    @poster_name = "Extreme Programming"
  when "manifesto"
    @video_url_code = "V5LaKpjcgKQ"
    @poster_name = "Principios Ágiles"
  end

  @pdf_download_url = "http://media.kleer.la/posters/#{@poster_code}.pdf"
  @image_url = "/img/posters/#{@poster_code}.jpg"

  erb :poster

end

get '/categoria/:category_codename' do
  @category = KeventerReader.instance.category(params[:category_codename])
  @active_tab_acompanamos = "active"

  if @category.nil?
    status 404
  else
    @page_title += " | " + @category.name
    @event_types = @category.event_types.sort_by { |et| et.name}

    erb :category
  end
end

get '/entrenamos/evento/:event_id_with_name' do
  event_id_with_name = params[:event_id_with_name]
  event_id = event_id_with_name.split('-')[0]
  if is_valid_id(event_id)
    @event = KeventerReader.instance.event(event_id, true)
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

get '/catalogo' do
  @active_tab_entrenamos = "active"
  #pdf_catalog
  @page_title += " | Catálogo"
  @categories = KeventerReader.instance.categories session[:locale]
  erb :catalogo
end

get '/categoria/:category_codename/cursos/:event_type_id_with_name' do
  @active_tab_entrenamos = "active"

  event_type_id_with_name = params[:event_type_id_with_name]
  event_type_id = event_type_id_with_name.split('-')[0]

  @category = KeventerReader.instance.category params[:category_codename], session[:locale]

  if is_valid_id(event_type_id)
    @event_type = KeventerReader.instance.event_type(event_type_id, true)
  end

  if @event_type.nil?
    flash.now[:error] = get_course_not_found_error()
    erb :error404_to_calendar
  else
   # @active_tab_entrenamos = "active"
   # @twitter_card = create_twitter_card( @event )
    @page_title = "Kleer - " + @event_type.name
    erb :event_type
  end
end

get '/entrenamos/evento/:event_id_with_name/entrenador/remote' do
  event_id_with_name = params[:event_id_with_name]

  event_id = event_id_with_name.split('-')[0]
  if is_valid_id(event_id)
    @event = KeventerReader.instance.event(event_id, false)
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
    @event = KeventerReader.instance.event(event_id, false)
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
    @event = KeventerReader.instance.event(event_id, false)
  end

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
    @event = KeventerReader.instance.event(event_id, true)
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
	@kleerers = KeventerReader.instance.kleerers session[:locale]
	erb :somos
end

get '/prensa' do
  @active_tab_prensa = "active"
  @page_title += " | Prensa"
  @kleerers = KeventerReader.instance.kleerers session[:locale]
  erb :prensa
end

get '/prensa/casos/equipos-scrum-en-technisys-2015' do
  @page_title += " | Equipos de desarrollo Scrum y Automatización en Technisys"
  @meta_description = "Kleer - Coaching & Training - Equipos de desarrollo Scrum y automatización de despliegue de software en Technisys apoyados por Kleer"
  @meta_keywords = "Kleer, Technisys, CyberBank, scrum, equipos, desarrollo ágil, devops, automatización, integración continua, jenkins"

  erb :prensa_casos_technisys_2015
end

get '/prensa/casos/equipos-scrum-en-plataforma-10-2015' do
  @page_title += " | Equipos de desarrollo Scrum y Automatización en Plataforma 10"
  @meta_description = "Kleer - Coaching & Training - Equipos de desarrollo Scrum y orientación al valor para el negocio en Plataforma 10, apoyados por Kleer"
  @meta_keywords = "Kleer, Plataforma 10, scrum, equipos, desarrollo ágil, devops, automatización, integración continua, valor negocio"

  erb :prensa_casos_plataforma_10_2015
end

get '/prensa/casos/equipos-scrum-en-suramericana-2015' do
  @page_title += " | Paradigma ágil en tecnología y en negocio en Suramericana"
  @meta_description = "Kleer - Coaching & Training - Paradigma ágiles en tecnología y en negocio en Suramericana, apoyados por Kleer"
  @meta_keywords = "Kleer, Suramericana, Sura, scrum, equipos, desarrollo ágil, valor negocio, corporaciones ágiles, paradigma ágil en las empresas"

  erb :prensa_casos_suramericana_2015
end

get '/prensa/casos/innovacion-en-marketing-digital-loreal-2016' do
  @page_title += " | Innovación en Marketing Digital en L'Oréal"
  @meta_description = "Kleer - Coaching & Training - Creación incremental y colaborativa de estrategias digitales facilitada por Kleer"
  @meta_keywords = "Kleer, L'Oréal, Loreal, Innovación, Design Thinking, facilitación, coloaboración, facilitación gráfica, marketing, digital"

  erb :prensa_casos_loreal_2016
end

get '/clientes' do
  @page_title += " | Nuestros clientes"
  @meta_description = "Kleer - Coaching & Training - Estas organizaciones confían en nosotros"
  @meta_keywords = "Kleer, Clientes, Casos, Casos de Éxito, confianza"

  erb :clientes
end

get '/last-tweet/:screen_name' do
  reader = TwitterReader.new
  return reader.last_tweet(params[:screen_name]).text
end

# JSON ====================

get '/entrenamos/eventos/proximos' do
  content_type :json
  DTHelper::to_dt_event_array_json(KeventerReader.instance.coming_commercial_events(), true, "entrenamos")
end

get '/entrenamos/eventos/proximos/:amount' do
  content_type :json
  amount = params[:amount]
  if !amount.nil?
    amount = amount.to_i
  end
  DTHelper::to_dt_event_array_json(KeventerReader.instance.coming_commercial_events(), true, "entrenamos", I18n, session[:locale], amount, false)
end

get '/entrenamos/eventos/pais/:country_iso_code' do
  content_type :json
  country_iso_code = params[:country_iso_code]
  if (!is_valid_country_iso_code(country_iso_code, "entrenamos"))
    country_iso_code = "todos"
  end
  session[:filter_country]= country_iso_code
  DTHelper::to_dt_event_array_json(KeventerReader.instance.commercial_events_by_country(country_iso_code), false, "entrenamos", I18n, session[:locale])
end

get '/comunidad/eventos/proximos/:amount' do
  content_type :json
  amount = params[:amount]
  if !amount.nil?
    amount = amount.to_i
  end
  DTHelper::to_dt_event_array_json(KeventerReader.instance.coming_community_events(), true, "comunidad", I18n, session[:locale], amount, false)
end

get '/comunidad/eventos/pais/:country_iso_code' do
  content_type :json
  country_iso_code = params[:country_iso_code]
  if (!is_valid_country_iso_code(country_iso_code, "comunidad"))
    country_iso_code = "todos"
  end
  DTHelper::to_dt_event_array_json(KeventerReader.instance.community_events_by_country(country_iso_code), false, "comunidad", I18n, session[:locale])
end

# STATIC FILES ==============

get '/preguntas-frecuentes/facturacion-pagos-internacionales' do
  erb :facturacion_pagos_internacionales
end

get '/preguntas-frecuentes/facturacion-pagos-argentina' do
  erb :facturacion_pagos_argentina
end

get '/preguntas-frecuentes/facturacion-pagos-colombia' do
  erb :facturacion_pagos_colombia
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

not_found do
  @page_title = "404 - No encontrado"

  if !request.path.index("/comunidad/yoseki").nil?
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
  card.creator = event.trainers[0].twitter_username
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
    unique_countries = KeventerReader.instance.unique_countries_for_commercial_events()
  else
    unique_countries = KeventerReader.instance.unique_countries_for_community_events()
  end
  unique_countries.each { |country|
    if (country.iso_code == country_iso_code_to_test)
      return true
    end
  }

  return false
end
