# encoding: utf-8
require 'json'
require 'i18n'

class DTHelper
  
  MONTHS_ES = { "Jan" => "Ene", "Feb" => "Feb", "Mar" => "Mar", "Apr" => "Abr", "May" => "May", "Jun" => "Jun",
                "Jul" => "Jul", "Aug" => "Ago", "Sep" => "Sep", "Oct" => "Oct", "Nov" => "Nov", "Dec" => "Dic"}
  
  def self.to_dt_event_array_json(events, remote = true, event_details_path = "entrenamos", i18n = I18n, locale = "es", amount = nil, registration_btn = true)
    result = Array.new
    
    printed = 0
    
    events.each do |event|
      result << DTHelper::event_result_json(event, remote, event_details_path, i18n, locale, registration_btn)
      printed += 1
      if !amount.nil? && printed==amount
        break
      end
    end
    
    "{ \"data\": " + result.to_json + "}"
  end
  
  def self.event_result_json(event, remote = true, event_details_path = "entrenamos", i18n, locale, registration_btn)
    result = Array.new
    
    #initial_date_line = "<div class=\"klabel-date\">" + event.date.strftime("%d") + "<br>" + MONTHS_ES[event.date.strftime("%b")] + "</div>"
    #if event.date != event.finish_date && !event.finish_date.nil?
    #  result << initial_date_line
    #  result << "<div class=\"klabel-date\">" + event.finish_date.strftime("%d") + "<br>" + MONTHS_ES[event.finish_date.strftime("%b")] + "</div>"
    #else
    #  result << " "
    #  result << initial_date_line
    #end

    date_line = "<table border=\"0\" align=\"center\" cellpadding=\"2\"><tr>"
    if event.date != event.finish_date && !event.finish_date.nil?
      post_it_width = "80px;"
      date_line += "<td>#{event.date.strftime("%d")}</td>"
      date_line += "<td rowspan=2>&nbsp;-&nbsp;</td>"
      date_line += "<td>#{event.finish_date.strftime("%d")}</td>"
      date_line += "</tr><tr>"
      date_line += "<td>#{MONTHS_ES[event.date.strftime("%b")]}</td>"
      date_line += "<td>#{MONTHS_ES[event.finish_date.strftime("%b")]}</td>"
    else
      post_it_width = "40px;"
      date_line += "<td>#{event.date.strftime("%d")}</td>"
      date_line += "</tr><tr>"
      date_line += "<td>#{MONTHS_ES[event.date.strftime("%b")]}</td>"
    end
    date_line += "</tr></table>"

    result << "<div class=\"klabel-date\" style=\"width:#{post_it_width}\">#{date_line}</div>"

    line = "<a "
    line += "href=\"/"+locale+"/"+event_details_path+"/evento/" + url_sanitize(event.uri_path)
    line += "\">" + event.event_type.name + "</a><br/>"
    if event.is_online
      line += "<img src=\"/img/flags/ol.png\"/> Online"
    else
      line += "<img src=\"/img/flags/" + event.country_code.downcase + ".png\"/> " + event.city + ", " + event.country
    end
    result << line
    
    if registration_btn
      if event.is_sold_out
        result << DTHelper::event_sold_out_link(i18n, locale)
     else
        result << DTHelper::event_link(event, i18n, locale)
      end
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

  def self.event_sold_out_link(i18n, locale)
    "<a href=\"javascript:void();\" target=\"_blank\" class=\"btn btn-danger\">#{i18n.t("general.buttons.complete", :locale => locale)}</a>"
  end
  
  def self.event_link(event, i18n, locale)
    if event.is_community_event
      button_text = i18n.t("general.buttons.register", :locale => locale)
    else
      button_text = i18n.t("general.buttons.i_am_interested", :locale => locale)
    end
    if event.registration_link != ""
      "<a href=\""+event.registration_link+"\" target=\"_blank\" class=\"btn btn-success btn-kleer\">#{button_text}</a>"
    else
      "<a data-toggle=\"modal\" data-target=\"#myModalRegistration\" href=\"/"+locale+"/entrenamos/evento/"+event.id.to_s+"/registration\" class=\"btn btn-info btn-kleer\">#{button_text}</a>"
    end
  end
  
end