# encoding: utf-8
require File.join(File.dirname(__FILE__),'../lib/dt_helper')
require File.join(File.dirname(__FILE__),'../lib/keventer_event')
require File.join(File.dirname(__FILE__),'../lib/keventer_event_type')
require 'date'

describe DTHelper do
  
  it "should return a certain string for a sold out event" do
    some_events = Array.new
    an_event = KeventerEvent.new
    an_event.event_type = KeventerEventType.new
    
    an_event.date = Date.parse("2012-12-04")
    an_event.id = 14
    an_event.event_type.name = "Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)"
    an_event.country_code = "AR"
    an_event.city = "Buenos Aires"
    an_event.is_sold_out = true
  
    some_events << an_event
    
    DTHelper::to_dt_event_array(some_events).should == "[['<span class=\"label label-info\">04<br><span class=\"lead\">Dec</span></span>',' <a data-toggle=\"modal\" data-target=\"#myModal\" href=\"/entrenamos/evento/14/remote\">Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)</a><br/><img src=\"/img/flags/ar.png\"/> Buenos Aires','<a href=\"javascript:void();\" target=\"_blank\"  class=\"btn btn-danger\">Completo</a>'],];"
    DTHelper::to_dt_event_array(some_events, false).should == "[['<span class=\"label label-info\">04<br><span class=\"lead\">Dec</span></span>',' <a data-toggle=\"modal\" data-target=\"#myModal\" href=\"/entrenamos/evento/14\">Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)</a><br/><img src=\"/img/flags/ar.png\"/> Buenos Aires','<a href=\"javascript:void();\" target=\"_blank\"  class=\"btn btn-danger\">Completo</a>'],];"
  
  end
  
  it "should return a certain string for a still valid event" do
    some_events = Array.new
    an_event = KeventerEvent.new
    an_event.event_type = KeventerEventType.new
    
    an_event.date = Date.parse("2012-12-04")
    an_event.id = 14
    an_event.event_type.name = "Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)"
    an_event.country_code = "AR"
    an_event.city = "Buenos Aires"
    an_event.is_sold_out = false
    an_event.registration_link = "https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new"
  
    some_events << an_event
    
    DTHelper::to_dt_event_array(some_events, false).should == "[['<span class=\"label label-info\">04<br><span class=\"lead\">Dec</span></span>',' <a data-toggle=\"modal\" data-target=\"#myModal\" href=\"/entrenamos/evento/14\">Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)</a><br/><img src=\"/img/flags/ar.png\"/> Buenos Aires','<a href=\"https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new\" target=\"_blank\"  class=\"btn btn-success\">Registrarme!</a>'],];"
  
  end
  
end