# encoding: utf-8
require 'json'

class DTHelper
  
  MONTHS_ES = { "Jan" => "Ene", "Feb" => "Feb", "Mar" => "Mar", "Apr" => "Abr", "May" => "May", "Jun" => "Jun",
                "Jul" => "Jul", "Aug" => "Ago", "Sep" => "Sep", "Oct" => "Oct", "Nov" => "Nov", "Dec" => "Dic"}
  
  def self.to_dt_event_array_json(events, remote = true)
    result = Array.new
    
    events.each do |event|
      result << DTHelper::event_result_json(event, remote)
    end
    
    "{ \"aaData\": " + result.to_json + "}"
  end
  
  def self.event_result_json(event, remote = true)
    result = Array.new
    
    result << "<span class=\"label label-info\">" + event.date.strftime("%d") + "<br><span class=\"lead\">" + MONTHS_ES[event.date.strftime("%b")] + "</span></span>"
    line = "<a "
    if remote 
      line += "data-toggle=\"modal\" data-target=\"#myModal\" "
      line += "href=\"/entrenamos/evento/" + event.uri_path + "/remote"
    else
      line += "href=\"/entrenamos/evento/" + event.uri_path
    end
    line += "\">" + event.event_type.name + "</a><br/>"
    line += "<img src=\"/img/flags/" + event.country_code.downcase + ".png\"/> " + event.city + ", " + event.country
    result << line
    
    if event.is_sold_out
      result << DTHelper::event_sold_out_link
    else
      result << DTHelper::event_link(event)
    end
    
    result
  end

  private
  
  def self.event_sold_out_link
    "<a href=\"javascript:void();\" target=\"_blank\" class=\"btn btn-danger\">Completo</a>"
  end
  
  def self.event_link(event)
    "<a href=\""+event.registration_link+"\" target=\"_blank\" class=\"btn btn-success\">Registrarme!</a>"
  end
  
end