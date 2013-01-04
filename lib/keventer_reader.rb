require 'libxml'
require 'date'
require File.join(File.dirname(__FILE__),'/keventer_event')
require File.join(File.dirname(__FILE__),'/keventer_event_type')
require File.join(File.dirname(__FILE__),'/country')

class KeventerReader

  def initialize(xml_path)
    @xml_path = xml_path
  end
  
  def events
    load_remote_events()
  end
  
  def coming_events(from = Date.today, months = 2)
    coming_events = Array.new

    load_remote_events().each do |event|
      if event.date <= (from >> months)
        coming_events << event
      end
    end

    coming_events
  end
  
  def events_by_country(country_iso_code, from = Date.today)
    events_by_country = Array.new

    # FIXME
    # esto es feo, tenemos que resolver de otra manera la situacion
    # en la cual el usuario no encuentra cursos.
    if country_iso_code == "otro"
      return events_by_country
    end

    load_remote_events().each do |event|
      if (country_iso_code == "todos" or 
          event.country_code.downcase == "ol" or
          event.country_code.downcase == country_iso_code)
        events_by_country << event
      end
    end

    events_by_country
  end
  
  def event(event_id, force_read = false)
    load_remote_event(event_id, force_read)
  end
  
  def unique_countries()
    countries = Array.new
    online_country = nil

    load_remote_events().each do |event|
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

  private
  
  def load_remote_events(force_read = true)
    if remote_events_still_valid(force_read)
      return @events_dont_use_directly
    end
    
    parser =  LibXML::XML::Parser.file(@xml_path)
    doc = parser.parse
    loaded_events = doc.find('/events/event')
    
    events = Array.new
    loaded_events.each do |loaded_event|
      events << create_event(loaded_event)
    end

    @events_dont_use_directly = events
  end

  def load_remote_event(event_id, force_read = false)
    event_id = event_id.to_i

    load_remote_events(force_read).each do |event|
      if event.id == event_id
        return  event
      end
    end
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
    event.registration_link = xml_keventer_event.find_first('registration-link').content
    event.is_sold_out = to_boolean( xml_keventer_event.find_first('is-sold-out').content )
    event.country = xml_keventer_event.find_first('country/name').content
    event.country_code = xml_keventer_event.find_first('country/iso-code').content
    event.trainer_name = xml_keventer_event.find_first('trainer/name').content
    event.trainer_bio = xml_keventer_event.find_first('trainer/bio').content
    
    event_type.name  = xml_keventer_event.find_first('event-type/name').content
    event_type.description  = xml_keventer_event.find_first('event-type/description').content
    event_type.goal  = xml_keventer_event.find_first('event-type/goal').content
    event_type.recipients  = xml_keventer_event.find_first('event-type/recipients').content
    event_type.program  = xml_keventer_event.find_first('event-type/program').content
    
    event.event_type = event_type
    
    event
  end
  
  def remote_events_still_valid(force_read)
    !(@events_dont_use_directly.nil? || force_read)
  end

  @events_dont_use_directly = nil
  
end
