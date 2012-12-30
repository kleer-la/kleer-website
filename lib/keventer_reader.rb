require 'libxml'
require 'date'
require File.join(File.dirname(__FILE__),'/keventer_event')
require File.join(File.dirname(__FILE__),'/keventer_event_type')

class KeventerReader
  
  def initialize( xml_path, starting_on = Date.today )
    @xml_path = xml_path
    @starting_on = starting_on
  end
  
  def events
    load_events
    @events
  end
  
  def event(event_id, force_read = false)
    load_event(event_id, force_read)
  end
  
  def events_for_two_months
    load_events( @starting_on )
    @events_for_two_months
  end
  
  private
  
  def load_event( event_id, force_read = false )
    if @events.nil? || force_read
      load_events
    end
    
    event_id = event_id.to_i
    
    returning_event = nil
    
    @events.each do |event|
      if event.id == event_id
        returning_event = event
      end
    end
    
    returning_event
    
  end
  
  def load_events( starting_on = Date.today  )
    @events = Array.new
    @events_for_two_months = Array.new
    parser =  LibXML::XML::Parser.file( @xml_path )
    doc = parser.parse
    
    loaded_events = doc.find('/events/event')
    
    loaded_events.each do |loaded_event|   
      event = create_event(loaded_event)
      
      @events << event

      if event.date <= (starting_on >> 2)
        @events_for_two_months << event
      end
    end
  
    (@events.count >= 0)
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
  
end