#encoding: utf-8

require 'libxml'
require 'date'
require 'tzinfo'

require File.join(File.dirname(__FILE__),'/keventer_event')
require File.join(File.dirname(__FILE__),'/keventer_event_type')
require File.join(File.dirname(__FILE__),'/country')
require File.join(File.dirname(__FILE__),'/keventer_connector')
require File.join(File.dirname(__FILE__),'/professional')
require File.join(File.dirname(__FILE__),'/category')

def to_boolean(string)
  return true if string== true || string =~ (/(true|t|yes|y|1)$/i)
  return false if string== false || string.nil? || string == "" || string =~ (/(false|f|no|n|0)$/i)
  raise ArgumentError.new("invalid value for Boolean: \"#{string}\"")
end

def validated_Date_parse(date_xml)
    begin
      Date.parse( date_xml.content)
    rescue
      nil
    end
end

def first_content xml, element_name
  element= xml.find_first(element_name)
  if element.nil?
    ""
  else
    element.content
  end
end

def event_from_parsed_xml(xml_keventer_event)
    event = KeventerEvent.new
    event.load xml_keventer_event
    return event

    event.id = xml_keventer_event.find_first('id').content.to_i
    event.date = Date.parse( xml_keventer_event.find_first('date').content )
    event.finish_date = validated_Date_parse(xml_keventer_event.find_first('finish-date'))
    # event.human_date = xml_keventer_event.find_first('human-date').content
    event.start_time = DateTime.parse( xml_keventer_event.find_first('start-time').content )
    event.end_time = DateTime.parse( xml_keventer_event.find_first('end-time').content )
    event.capacity = xml_keventer_event.find_first('capacity').content.to_i
    event.city = xml_keventer_event.find_first('city').content
    event.place = xml_keventer_event.find_first('place').content
    event.address = xml_keventer_event.find_first('address').content
    event.registration_link = xml_keventer_event.find_first('registration-link').content
    event.specific_conditions = xml_keventer_event.find_first('specific-conditions').content
    event.is_sold_out = to_boolean( xml_keventer_event.find_first('is-sold-out').content )

    event.show_pricing = to_boolean( xml_keventer_event.find_first('show-pricing').content )
    event.list_price = xml_keventer_event.find_first('list-price').content.nil? ? 0.0 : xml_keventer_event.find_first('list-price').content.to_f
    event.eb_price = xml_keventer_event.find_first('eb-price').content.nil? ? 0.0 : xml_keventer_event.find_first('eb-price').content.to_f
    if event.eb_price > 0.0
        event.eb_end_date = validated_Date_parse(xml_keventer_event.find_first('eb-end-date'))
    end
    event.couples_eb_price = xml_keventer_event.find_first('couples-eb-price').content.nil? ? 0.0 : xml_keventer_event.find_first('couples-eb-price').content.to_f
    event.business_eb_price = xml_keventer_event.find_first('business-eb-price').content.nil? ? 0.0 : xml_keventer_event.find_first('business-eb-price').content.to_f
    event.business_price = xml_keventer_event.find_first('business-price').content.nil? ? 0.0 : xml_keventer_event.find_first('business-price').content.to_f
    event.enterprise_6plus_price = xml_keventer_event.find_first('enterprise-6plus-price').content.nil? ? 0.0 : xml_keventer_event.find_first('enterprise-6plus-price').content.to_f
    event.enterprise_11plus_price = xml_keventer_event.find_first('enterprise-11plus-price').content.nil? ? 0.0 : xml_keventer_event.find_first('enterprise-11plus-price').content.to_f

    event.is_webinar = to_boolean( xml_keventer_event.find_first('is-webinar').content )
    event.mode = xml_keventer_event.find_first('mode').content

    if xml_keventer_event.find_first('sepyme-enabled').content == ""
      event.sepyme_enabled = false
    else
      event.sepyme_enabled = to_boolean( xml_keventer_event.find_first('sepyme-enabled').content )
    end
    event.is_community_event = xml_keventer_event.find_first('visibility-type').content == 'co'
    event.country = xml_keventer_event.find_first('country/name').content
    event.country_code = xml_keventer_event.find_first('country/iso-code').content
    event.currency_iso_code = xml_keventer_event.find_first('currency-iso-code').content

  event
end


class KeventerReader

  attr_accessor :connector

  def initialize( connector = nil )
    if connector.nil?
      @connector = KeventerConnector.new
    else
      @connector = connector
    end
    @events_hash_dont_use_directly = Hash.new
  end

  def events
    load_remote_events()
  end

  def coming_commercial_events(from = Date.today, months = 2)
    coming_events(@connector.events_xml_url, from , months )
  end

  def coming_community_events(from = Date.today, months = 2)
    coming_events(@connector.community_events_xml_url, from , months )
  end

  def commercial_events_by_country(country_iso_code)
    events_by_country( @connector.events_xml_url, country_iso_code )
  end

  def community_events_by_country(country_iso_code)
    events_by_country( @connector.community_events_xml_url, country_iso_code )
  end

  def event(event_id, force_read = false)
    load_remote_event(event_id, force_read)
  end

  def event_type(event_type_id, force_read = false)
    event_type = load_remote_event_type(event_type_id, force_read)
    if !event_type.nil?
      event_type.public_editions = load_remote_event_type_editions(event_type_id, force_read)
    end
    event_type
  end

  def unique_countries_for_commercial_events
    unique_countries( @connector.events_xml_url )
  end

  def unique_countries_for_community_events
    unique_countries( @connector.community_events_xml_url )
  end

  def parse file, node
      parser =  LibXML::XML::Parser.file( file )
      doc = parser.parse
      doc.find(node)
  end

  def kleerers(lang="es")
    kleerers = Array.new

    begin
      loaded_kleerers = parse @connector.kleerers_xml_url, '/trainers/trainer'

      loaded_kleerers.each do |one_kleerer|
        kleerer = Professional.new one_kleerer, lang
        kleerers << kleerer
      end
    rescue => err
      puts "Error al cargar kleerers: #{err}"
      kleerers = Array.new
    end

    kleerers
  end

  def category(code_name, lang="es")
    all = categories lang
    all.select { |category| category.codename == code_name }.first
  end

  def categories(lang="es")
    categories = Array.new

    begin
      loaded_categories = parse @connector.categories_xml_url, '/categories/category'

      loaded_categories.each do |loaded_category|
        category = Category.new loaded_category, lang

        category.event_types = load_event_types loaded_category

        categories << category
      end

      categories.sort!{|p1,p2| p1.order <=> p2.order}
    rescue => err
      puts "Error al cargar las categorías: #{err}"
      categories = Array.new
    end

    categories
  end

  private
  def load_event_types event_types_xml_node

    event_types = Array.new
    if !event_types_xml_node.nil?
      event_types_xml_node.find('event-types/event-type ').each do |event_type_node|

        event_type = create_event_type( event_type_node )

        if event_type.include_in_catalog
          event_types << event_type
        end
      end
    end
    event_types
  end

  private
  def coming_events(event_type_xml_url, from = Date.today, months = 2)
    coming_events = Array.new

    load_remote_events( event_type_xml_url ).each do |event|
      if event.date <= (from >> months)
        coming_events << event
      end
    end

    coming_events
  end

  def events_by_country(event_type_xml_url, country_iso_code)
    events_by_country = Array.new

    # FIXME
    # esto es feo, tenemos que resolver de otra manera la situacion
    # en la cual el usuario no encuentra cursos.
    if country_iso_code == "otro"
      return events_by_country
    end

    load_remote_events( event_type_xml_url ).each do |event|
      if (country_iso_code == "todos" or
          event.country_code.downcase == "ol" or
          event.country_code.downcase == country_iso_code)
        events_by_country << event
      end
    end

    events_by_country
  end

  def unique_countries( event_type_xml_url )
    countries = Array.new
    online_country = nil

    load_remote_events( event_type_xml_url ).each do |event|
      if event.country_code.downcase == "ol"
        online_country = Country.new("ol", "Online")
      else
        country = Country.new(event.country_code.downcase, event.country)
        countries << country unless countries.include?(country)
      end
    end

    countries.sort! { |x, y| x.name <=> y.name }

    # Despues de que esta ordenado agrego Online al final
    countries << online_country unless online_country.nil?

    countries
  end

  def load_remote_events(event_type_xml_url = @connector.events_xml_url, force_read = true)

    if remote_events_still_valid(event_type_xml_url, force_read)
      return @events_hash_dont_use_directly[event_type_xml_url]
    end
    loaded_events = parse event_type_xml_url, '/events/event'

    events = Array.new
    loaded_events.each do |loaded_event|
      events << create_event(loaded_event)
    end

    @events_hash_dont_use_directly[event_type_xml_url] = events
  end

  def load_remote_event(event_id, force_read = false)
    event = nil

    event_id = event_id.to_i

    load_remote_events(@connector.events_xml_url, force_read).each do |event_found|
      if event_found.id == event_id
        event = event_found
      end
    end

    if event.nil?

      load_remote_events(@connector.community_events_xml_url, force_read).each do |event_found|
        if event_found.id == event_id
          event = event_found
        end
      end

    end

    event
  end

  def load_remote_event_type(event_type_id, force_read = false)
    event_type_id = event_type_id.to_i

    begin
      url = @connector.event_type_url(event_type_id)
      parser =  LibXML::XML::Parser.file(url )
      doc = parser.parse
      create_event_type(doc)
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
  end

  def load_remote_event_type_editions(event_type_id, force_read)
    all_events = load_remote_events( @connector.events_xml_url , force_read)

    public_editions = Array.new

    all_events.each do |event|
     if event.event_type.id == event_type_id.to_i
        public_editions << event
      end
    end

    public_editions

  end

  def create_event(xml_keventer_event)

    event = event_from_parsed_xml(xml_keventer_event)

    trainer = Professional.new  #xml_keventer_event.find_first('trainer'), "es"

    trainer.name = xml_keventer_event.find_first('trainer/name').content
    trainer.bio = xml_keventer_event.find_first('trainer/bio').content
    trainer.id = xml_keventer_event.find_first('trainer/id').content
    trainer.linkedin_url = xml_keventer_event.find_first('trainer/linkedin-url').content
    trainer.gravatar_picture_url = xml_keventer_event.find_first('trainer/gravatar-picture-url').content
    trainer.twitter_username = xml_keventer_event.find_first('trainer/twitter-username').content

    trainer.average_rating = xml_keventer_event.find_first('trainer/average-rating').content.nil? ? nil : xml_keventer_event.find_first('trainer/average-rating').content.to_f.round(2)
    trainer.net_promoter_score = xml_keventer_event.find_first('trainer/net-promoter-score').content.nil? ? nil : xml_keventer_event.find_first('trainer/net-promoter-score').content.to_i
    trainer.surveyed_count = xml_keventer_event.find_first('trainer/surveyed-count').content.to_i
    trainer.promoter_count = xml_keventer_event.find_first('trainer/promoter-count').content.to_i

    event.trainer = trainer

    if xml_keventer_event.find_first('trainer2')
      trainer2 = Professional.new  #xml_keventer_event.find_first('trainer2'), "es"

      trainer2.name = xml_keventer_event.find_first('trainer2/name').content
      trainer2.bio = xml_keventer_event.find_first('trainer2/bio').content
      trainer2.id = xml_keventer_event.find_first('trainer2/id').content
      trainer2.linkedin_url = xml_keventer_event.find_first('trainer2/linkedin-url').content
      trainer2.gravatar_picture_url = xml_keventer_event.find_first('trainer2/gravatar-picture-url').content
      trainer2.twitter_username = xml_keventer_event.find_first('trainer2/twitter-username').content
    else
      trainer2 = nil
    end

    event.trainer2 = trainer2

    event.event_type = create_event_type(xml_keventer_event.find_first('event-type'))

    event.keventer_connector = @connector

    event
  end

  def create_event_type(xml_keventer_event)
    event_type = KeventerEventType.new
    event_type.load xml_keventer_event
    event_type
  end

  def remote_events_still_valid(event_type_xml_url, force_read)
    !(@events_hash_dont_use_directly[event_type_xml_url].nil? || force_read)
  end

end
