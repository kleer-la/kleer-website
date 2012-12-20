require 'libxml'
require 'date'
require File.join(File.dirname(__FILE__),'/keventer_event')
require File.join(File.dirname(__FILE__),'/keventer_event_type')

class KeventerReader
  
  attr_reader :events, :events_for_two_months
  
  def initialize
    @events = Array.new
    @events_for_two_months = Array.new
    @last_load_datetime = nil
  end
  
  def load_events( path, todays_date = Date.today, override_cache = false )
    execution_date = DateTime.now
    if override_cache || @last_load_datetime.nil? || (execution_date > @last_load_datetime+1)
      @last_load_datetime = execution_date
      
      parser =  LibXML::XML::Parser.file( path )
      doc = parser.parse
    
      loaded_events = doc.find('/events/event')
    
      loaded_events.each do |loaded_event|      
        event = create_event(loaded_event)
      
        @events << event

        if event.date <= (todays_date >> 2)
          @events_for_two_months << event
        end
      end
    
      return (@events.count >= 0)
    else
      return false
    end
  end
  
  private

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
    
    event_type.name  = xml_keventer_event.find_first('event-type/name').content
    event_type.description  = xml_keventer_event.find_first('event-type/description').content
    event_type.goal  = xml_keventer_event.find_first('event-type/goal').content
    event_type.recipients  = xml_keventer_event.find_first('event-type/recipients').content
    event_type.program  = xml_keventer_event.find_first('event-type/program').content
    
    event.event_type = event_type
    
    event
  end
  
end