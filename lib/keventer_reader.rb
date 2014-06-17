require 'libxml'
require 'date'
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

def get_from_xml(xml, field)
  xml.find_first(field).content
end

def event_from_parsed_xml(xml_keventer_event)
    event = KeventerEvent.new

    event.id        = get_from_xml(xml_keventer_event,'id').to_i
    event.date      = Date.parse(get_from_xml(xml_keventer_event,'date'))
    event.start_time = DateTime.parse(get_from_xml(xml_keventer_event, 'start-time'))
    event.end_time  = DateTime.parse(get_from_xml(xml_keventer_event, 'end-time'))
    event.capacity  = get_from_xml(xml_keventer_event, 'capacity').to_i
    event.city      = get_from_xml(xml_keventer_event, 'city')
    event.place     = get_from_xml(xml_keventer_event, 'place')
    event.address   = get_from_xml(xml_keventer_event, 'address')
    event.registration_link = get_from_xml(xml_keventer_event, 'registration-link')
    event.specific_conditions = get_from_xml(xml_keventer_event, 'specific-conditions')
    event.is_sold_out = to_boolean(get_from_xml(xml_keventer_event, 'is-sold-out'))
    event.is_webinar = to_boolean(get_from_xml(xml_keventer_event, 'is-webinar'))
    event.sepyme_enabled = to_boolean( get_from_xml(xml_keventer_event,'sepyme-enabled') )
    event.is_community_event = get_from_xml(xml_keventer_event,'visibility-type') == 'co'
    event.country = get_from_xml(xml_keventer_event,'country/name')
    event.country_code = get_from_xml(xml_keventer_event, 'country/iso-code')
    lp = get_from_xml(xml_keventer_event, 'list-price')
    event.list_price = lp.nil? ? 0.0 : lp.to_f
    ebp = get_from_xml(xml_keventer_event, 'eb-price')
    event.eb_price = ebp.nil? ? 0.0 : ebp.to_f
    if event.eb_price > 0.0
      begin
        ebed = get_from_xml(xml_keventer_event, 'eb-end-date')
        event.eb_end_date = ebed.nil? ? nil : Date.parse( ebed )
      rescue
        event.eb_end_date = nil
      end
    end
    event.currency_iso_code = get_from_xml(xml_keventer_event, 'currency-iso-code')
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
  
  def kleerers
    parser =  LibXML::XML::Parser.file( @connector.kleerers_xml_url )
    doc = parser.parse
    loaded_kleerers = doc.find('/trainers/trainer')
    
    kleerers = Array.new
    
    loaded_kleerers.each do |loaded_kleerer|
      kleerer = Professional.new
      
      kleerer.name = loaded_kleerer.find_first('name').content
      kleerer.bio = loaded_kleerer.find_first('bio').content
      kleerer.linkedin_url = loaded_kleerer.find_first('linkedin-url').content
      kleerer.gravatar_picture_url = loaded_kleerer.find_first('gravatar-picture-url').content
      kleerer.twitter_username = loaded_kleerer.find_first('twitter-username').content
      
      kleerers << kleerer
    end
    
    kleerers
  end
  
  def category(code_name)
    all = categories
    all.select { |category| category.codename == code_name }.first
  end
  
  def categories
    parser =  LibXML::XML::Parser.file( @connector.categories_xml_url )
    doc = parser.parse
    loaded_categories = doc.find('/categories/category')
    
    categories = Array.new
    
    loaded_categories.each do |loaded_category|
      category = Category.new
      
      category.name = loaded_category.find_first('name').content
      category.codename = loaded_category.find_first('codename').content
      category.tagline = loaded_category.find_first('tagline').content
      category.description = loaded_category.find_first('description').content
      category.order = loaded_category.find_first('order').content.to_i
      
      category.event_types = load_event_types loaded_category

      categories << category
    end
    
    categories.sort!{|p1,p2| p1.order <=> p2.order}
    
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
    
    parser =  LibXML::XML::Parser.file( event_type_xml_url )
    doc = parser.parse
    loaded_events = doc.find('/events/event')
    
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
      parser =  LibXML::XML::Parser.file( @connector.event_type_url(event_type_id))
      doc = parser.parse
      create_event_type(doc)
    rescue Exception
      nil
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
    
    trainer = Professional.new
    
    trainer.name = xml_keventer_event.find_first('trainer/name').content
    trainer.bio = xml_keventer_event.find_first('trainer/bio').content
    trainer.id = xml_keventer_event.find_first('trainer/id').content
    trainer.linkedin_url = xml_keventer_event.find_first('trainer/linkedin-url').content
    trainer.gravatar_picture_url = xml_keventer_event.find_first('trainer/gravatar-picture-url').content
    trainer.twitter_username = xml_keventer_event.find_first('trainer/twitter-username').content
    event.trainer = trainer

    event.event_type = create_event_type(xml_keventer_event.find_first('event-type'))
    
    event.keventer_connector = @connector
    
    event
  end
  
  def create_event_type(xml_keventer_event)
    
    event_type = KeventerEventType.new
    event_type.id  = xml_keventer_event.find_first('id').content.to_i
    event_type.name  = xml_keventer_event.find_first('name').content
    event_type.duration = xml_keventer_event.find_first('duration').content.to_i
    event_type.elevator_pitch  = xml_keventer_event.find_first('elevator-pitch').content
    event_type.learnings  = xml_keventer_event.find_first('learnings').content
    event_type.takeaways  = xml_keventer_event.find_first('takeaways').content
    event_type.description  = xml_keventer_event.find_first('description').content
    event_type.goal  = xml_keventer_event.find_first('goal').content
    event_type.recipients  = xml_keventer_event.find_first('recipients').content
    event_type.program  = xml_keventer_event.find_first('program').content
    event_type.faqs  = xml_keventer_event.find_first('faq').content
    event_type.elevator_pitch = xml_keventer_event.find_first('elevator-pitch').content
    event_type.include_in_catalog = to_boolean( xml_keventer_event.find_first('include-in-catalog').content )

    event_type
  end    

  def remote_events_still_valid(event_type_xml_url, force_read)
    !(@events_hash_dont_use_directly[event_type_xml_url].nil? || force_read)
  end

end
