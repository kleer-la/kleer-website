require 'libxml'
require 'date'
require File.join(File.dirname(__FILE__),'/keventer_event')
require File.join(File.dirname(__FILE__),'/keventer_event_type')
require File.join(File.dirname(__FILE__),'/country')
require File.join(File.dirname(__FILE__),'/keventer_connector')
require File.join(File.dirname(__FILE__),'/professional')

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

  def to_boolean(string)
    return true if string== true || string =~ (/(true|t|yes|y|1)$/i)
    return false if string== false || string.nil? || string =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{string}\"")
  end
  
  def create_event(xml_keventer_event)
    event = KeventerEvent.new
    event_type = KeventerEventType.new
    
    event.id = xml_keventer_event.find_first('id').content.to_i
    event.date = Date.parse( xml_keventer_event.find_first('date').content )
    event.capacity = xml_keventer_event.find_first('capacity').content.to_i
    event.city = xml_keventer_event.find_first('city').content
    event.place = xml_keventer_event.find_first('place').content
    event.registration_link = xml_keventer_event.find_first('registration-link').content
    event.is_sold_out = to_boolean( xml_keventer_event.find_first('is-sold-out').content )
    event.country = xml_keventer_event.find_first('country/name').content
    event.country_code = xml_keventer_event.find_first('country/iso-code').content
    
    trainer = Professional.new
    
    trainer.name = xml_keventer_event.find_first('trainer/name').content
    trainer.bio = xml_keventer_event.find_first('trainer/bio').content
    trainer.id = xml_keventer_event.find_first('trainer/id').content
    trainer.linkedin_url = xml_keventer_event.find_first('trainer/linkedin-url').content
    trainer.gravatar_picture_url = xml_keventer_event.find_first('trainer/gravatar-picture-url').content
    trainer.twitter_username = xml_keventer_event.find_first('trainer/twitter-username').content
    event.trainer = trainer
    
    event_type.name  = xml_keventer_event.find_first('event-type/name').content
    event_type.description  = xml_keventer_event.find_first('event-type/description').content
    event_type.goal  = xml_keventer_event.find_first('event-type/goal').content
    event_type.recipients  = xml_keventer_event.find_first('event-type/recipients').content
    event_type.program  = xml_keventer_event.find_first('event-type/program').content
    
    event.event_type = event_type
    
    event.keventer_connector = @connector
    
    event
  end
  
  def remote_events_still_valid(event_type_xml_url, force_read)
    !(@events_hash_dont_use_directly[event_type_xml_url].nil? || force_read)
  end

end
