# encoding: utf-8
require 'date'
require 'i18n'
require 'spec_helper'
require File.join(File.dirname(__FILE__),'../lib/dt_helper')
require File.join(File.dirname(__FILE__),'../lib/keventer_event')
require File.join(File.dirname(__FILE__),'../lib/keventer_event_type')

describe DTHelper do
  
  before(:each) do
    I18n.enforce_available_locales = true  
    I18n.load_path += Dir[File.join(File.dirname(__FILE__), '../locales', '*.yml').to_s]
  end
  
  it "should return a certain string for a sold out event" do
    some_events = Array.new
    an_event = KeventerEvent.new
    an_event.event_type = KeventerEventType.new
    
    an_event.date = Date.parse("2012-12-04")
    an_event.id = 14
    an_event.event_type.name = "Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)"
    an_event.country = "Argentina"
    an_event.country_code = "AR"
    an_event.city = "Buenos Aires"
    an_event.is_sold_out = true
  
    some_events << an_event

    expect(DTHelper::to_dt_event_array_json(some_events)).to include("Completo")
    expect(DTHelper::to_dt_event_array_json(some_events, false)).to include("Completo")

  end
  
  it "should return a certain string for a still valid event" do
    some_events = Array.new
    an_event = KeventerEvent.new
    an_event.event_type = KeventerEventType.new
    
    an_event.date = Date.parse("2012-12-04")
    an_event.id = 14
    an_event.event_type.name = "Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)"
    an_event.country= "Argentina"
    an_event.country_code = "AR"
    an_event.city = "Buenos Aires"
    an_event.is_sold_out = false
    an_event.registration_link = "https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new"
  
    some_events << an_event

    expect(DTHelper::to_dt_event_array_json(some_events)).not_to include("Completo")
    expect(DTHelper::to_dt_event_array_json(some_events, false)).not_to include("Completo")  
  end
end