# encoding: utf-8
class DTHelper
  
  def self.to_dt_event_array(events)
    result = "["
    
    events.each do |event|
      result += DTHelper::event_result(event)
    end
    
    result += "];"
    
    result
  end
  
  def self.event_result(event)
    result = "["
    
    result += "'"+event.date.strftime("%d-%b")+"',"
    result += "' <a href=\"http://www.kleer.la/entrenamos/evento/"+event.id.to_s+"\">"+event.event_type.name+"</a><br/>"
    result += "<img src=\"/img/flags/"+event.country_code.downcase+".png\"/> "+event.city+"',"
    
    if event.is_sold_out
      result += DTHelper::event_sold_out_link
    else
      result += DTHelper::event_link(event)
    end
    
    result += "],"
  end
  
  def self.event_sold_out_link
    "'<a href=\"javascript:void();\" target=\"_blank\"  class=\"btn btn-danger\">Completo</a>'"
  end
  
  def self.event_link(event)
    "'<a href=\""+event.registration_link+"\" target=\"_blank\"  class=\"btn btn-success\">Registrarme!</a>'"
  end
  
end