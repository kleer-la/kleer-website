# encoding: utf-8
class DTHelper
  
  MONTHS_ES = { "Jan" => "Ene", "Feb" => "Feb", "Mar" => "Mar", "Apr" => "Abr", "May" => "May", "Jun" => "Jun",
                "Jul" => "Jul", "Aug" => "Ago", "Sep" => "Sep", "Oct" => "Oct", "Nov" => "Nov", "Dec" => "Dic"}
  
  def self.to_dt_event_array(events, remote = true)
    result = "["
    
    events.each do |event|
      result += DTHelper::event_result(event, remote)
    end
    
    result += "];"
    
    result
  end
  
  def self.event_result(event, remote = true)
    result = "["
    
    result += "'<span class=\"label label-info\">"+event.date.strftime("%d")+"<br><span class=\"lead\">"+MONTHS_ES[event.date.strftime("%b")]+"</span></span>',"
    result += "' <a data-toggle=\"modal\" data-target=\"#myModal\" href=\"/entrenamos/evento/"+event.id.to_s
    if remote 
      result += "/remote"
    end
    result += "\">"+event.event_type.name+"</a><br/>"
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
    "'<a href=\""+event.registration_link+"\" target=\"_blank\" class=\"btn btn-success\">Registrarme!</a>'"
  end
  
end