# encoding: utf-8
require 'json'

class DTHelper
  
  MONTHS_ES = { "Jan" => "Ene", "Feb" => "Feb", "Mar" => "Mar", "Apr" => "Abr", "May" => "May", "Jun" => "Jun",
                "Jul" => "Jul", "Aug" => "Ago", "Sep" => "Sep", "Oct" => "Oct", "Nov" => "Nov", "Dec" => "Dic"}
  
  def self.to_dt_event_array_json(events, remote = true, event_details_path = "entrenamos", amount = nil)
    result = Array.new
    
    printed = 0
    
    events.each do |event|
      result << DTHelper::event_result_json(event, remote, event_details_path)
      printed += 1
      if !amount.nil? && printed==amount
        break
      end
    end
    
    "{ \"aaData\": " + result.to_json + "}"
  end
  
  def self.event_result_json(event, remote = true, event_details_path = "entrenamos")
    result = Array.new
    
    result << "<span class=\"label label-info\">" + event.date.strftime("%d") + "<br><span class=\"lead\">" + MONTHS_ES[event.date.strftime("%b")] + "</span></span>"
    line = "<a "
    if remote 
      line += "data-toggle=\"modal\" data-target=\"#myModal\" "
      line += "href=\"/"+event_details_path+"/evento/" + url_sanitize(event.uri_path) + "/remote"
    else
      line += "href=\"/"+event_details_path+"/evento/" + url_sanitize(event.uri_path)
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
  
  def self.url_sanitize(data)
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

  def self.event_sold_out_link
    "<a href=\"javascript:void();\" target=\"_blank\" class=\"btn btn-danger\">Completo</a>"
  end
  
  def self.event_link(event)
    if event.registration_link != ""
      "<a href=\""+event.registration_link+"\" target=\"_blank\" class=\"btn btn-success\">Registrarme!</a>"
    else
      "<a data-toggle=\"modal\" data-target=\"#myModalRegistration\" href=\"/entrenamos/evento/"+event.id.to_s+"/registration\" class=\"btn btn-success\">Registrarme!</a>"
    end
  end
  
end