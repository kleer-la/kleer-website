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

    @some_events = Array.new
    an_event = KeventerEvent.new
    an_event.event_type = KeventerEventType.new

    an_event.date = Date.parse("2012-12-04")
    an_event.id = 14
    an_event.event_type.name = "Análisis, Estimación y Planificación con Scrum (Día 2 - CSD Track)"
    an_event.country = "Argentina"
    an_event.country_code = "AR"
    an_event.city = "Buenos Aires"
    an_event.is_sold_out = true
    an_event.registration_link = "https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new"

    @some_events << an_event

  end

  it "should return a certain string for a sold out event" do
    expect(DTHelper::to_dt_event_array_json(@some_events)).to include("Completo")
    expect(DTHelper::to_dt_event_array_json(@some_events, false)).to include("Completo")
  end

  it "should return a certain string for a still valid event" do
    @some_events[0].is_sold_out = false
    @some_events[0].registration_link = "https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new"

    expect(DTHelper::to_dt_event_array_json(@some_events)).not_to include("Completo")
    expect(DTHelper::to_dt_event_array_json(@some_events, false)).not_to include("Completo")
  end

  it "should return an empty json array when no event exist" do
      rsl = DTHelper::to_dt_event_array_json([], false, "comunidad", I18n)
      expect(rsl).to eq '{ "data": []}'
  end

  it "should take out diacritic(acute)" do
    expect(DTHelper::url_sanitize("áéíóúÁÉÍÓÚ")).to eq "aeiouAEIOU"
  end

end
