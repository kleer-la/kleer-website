# encoding: utf-8
require File.join(File.dirname(__FILE__),'../lib/keventer_reader')
require 'date'
require 'spec_helper'

describe "to_boolean" do
  it "Should convert string to true" do
    to_boolean("true").should be true
    to_boolean("True").should be true
    to_boolean("t").should be true
    to_boolean("yes").should be true
    to_boolean("y").should be true
    to_boolean("1").should be true
  end
  it "Should convert string to false" do
    to_boolean("false").should be false
    to_boolean("f").should be false
    to_boolean("no").should be false
    to_boolean("n").should be false
    to_boolean("").should be false
    to_boolean("0").should be false
    to_boolean(nil).should be false
  end
  it "should raise ArgumentError for arguments that are not boolean" do
    expect{ to_boolean("pepe") }.to raise_error(ArgumentError)
  end
end

describe KeventerReader do
  
  it "Should Be Able to Load an Xml File for Events" do
    @connector = double("KeventerConnector")
    @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/events.xml') )
    
    @kevr = KeventerReader.new( @connector )
    @kevr.events.count.should == 16   
  end

  it "Should Be Able to Load an Xml File for an Event Type" do
    @connector = double("KeventerConnector")
    @connector.stub(:events_xml_url).and_return( "http://keventer-test.herokuapp.com/api/events.xml" )
    @connector.stub(:event_type_url).and_return( File.join(File.dirname(__FILE__),'../spec/event_type_4.xml') )
    
    @kevr = KeventerReader.new( @connector )
    @kevr.event_type(4).id.should == 4   
  end
  
  it "Should Be Able to Load an Xml URI for Events" do
    @connector = double("KeventerConnector")
    @connector.stub(:events_xml_url).and_return( "http://keventer-test.herokuapp.com/api/events.xml" )
    
    @kevr = KeventerReader.new( @connector )
    @kevr.events.count.should >= 0
  end
  
  it "hola" do
    parser =  LibXML::XML::Parser.string( %Q{<?xml version="1.0" encoding="UTF-8"?>
  <event>
  <start-time type="datetime">2000-01-01T09:00:00Z</start-time>
  <end-time type="datetime">2000-01-01T18:00:00Z</end-time>
    <cancelled type="boolean">false</cancelled>
    <capacity type="integer">16</capacity>
    <city>Buenos Aires</city>
    <country-id type="integer">9</country-id>
    <created-at type="datetime">2012-11-28T22:48:51Z</created-at>
    <date type="date">2013-01-09</date>
    <draft type="boolean">false</draft>
    <eb-end-date type="date" nil="true"/>
    <eb-price type="decimal">750.0</eb-price>
    <event-type-id type="integer">13</event-type-id>
    <id type="integer">44</id>
    <is-sold-out type="boolean">false</is-sold-out>
    <specific-conditions>Unas condiciones propias del evento</specific-conditions>
  <is-webinar type="boolean">false</is-webinar>
  <sepyme-enabled type="boolean" nil="true"/>
    <list-price type="decimal">890.0</list-price>
  <currency-iso-code>ARS</currency-iso-code>
    <list-price-2-pax-discount type="integer">10</list-price-2-pax-discount>
    <list-price-3plus-pax-discount type="integer">15</list-price-3plus-pax-discount>
    <list-price-plus-tax type="boolean">true</list-price-plus-tax>
    <place>Kleer, Tucumán 373 1er Piso</place>
  <address>Tucuman 373 Piso 1</address>
    <registration-link>https://eventioz.com.ar/retrospectivas-9-ene-2012/registrations/new</registration-link>
    <trainer-id type="integer">4</trainer-id>
    <updated-at type="datetime">2012-11-28T22:56:20Z</updated-at>
    <visibility-type>pu</visibility-type>
    <country>
      <created-at type="datetime">2012-04-26T11:14:40Z</created-at>
      <id type="integer">9</id>
      <iso-code>AR</iso-code>
      <name>Argentina</name>
      <updated-at type="datetime">2012-04-26T11:14:40Z</updated-at>
    </country>
  </event>
}
      )
    ev = event_from_parsed_xml(parser.parse)
    ev.eb_end_date.should be_nil
  end

  context "When loading the testing XML source with 16 events" do
    
    before(:each) do
      @connector = double("KeventerConnector")
      @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/events.xml') )
      @connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/community_events.xml') )

      @kevr = KeventerReader.new( @connector )
    end
   
    it "Should allow access to an events array with all events" do
      @kevr.events.count.should == 16   
    end
    
    it "Should allow access to an events array for the next two months" do
      from = Date.parse("2012-12-20")
      @kevr.coming_commercial_events(from).count.should == 8
    end
    
    it "should be able to fetch a certain event" do
      @kevr.event(44).event_type.name.should == "Workshop de Retrospectivas"
    end
    
    it "should return NIL when fetching a non existing event" do
      @kevr.event(1).nil?.should == true
    end
    
    it "should be able to fetch a certain event if the parameter is a string" do
      @kevr.event("44").event_type.name.should == "Workshop de Retrospectivas"
    end
    
    it "should be able to fetch a certain community event" do
      @kevr.event(60).event_type.name.should == "Yoseki Coding Dojo"
    end
    
    it "should be signaled as community event" do
      @kevr.event(45).is_community_event.should == true
    end
    
    it "should not be signaled as community event" do
      @kevr.event(44).is_community_event.should == false
    end
    
    context "when examining the first event" do
      
      before(:each) do
        @first_event = @kevr.events.first
      end
      
      it "Should have it's capacity as 16" do
        @first_event.capacity.should == 16
      end
      
      it "Should have it's city in Buenos Aires" do
        @first_event.city.should == "Buenos Aires" 
      end
      
      it "Should have it's country in Argentina" do
        @first_event.country.should == "Argentina" 
      end
      
      it "Should have it's country_code in ar" do
        @first_event.country_code.should == "AR" 
      end

      it "Should have it's type like 'Workshop de Retrospectivas'" do
        @first_event.event_type.name.should == "Workshop de Retrospectivas"
      end
      
      it "Should have it's type goal as 'un objetivo.'" do
        @first_event.event_type.goal.should == "un objetivo."
      end
      
      it "Should have it's type description as 'una descripción.'" do
        @first_event.event_type.description.should == "una descripción."
      end
      
      it "Should have it's type recipients as 'los destinatarios.'" do
        @first_event.event_type.recipients.should == "los destinatarios."
      end
      
      it "Should have it's type program as 'el programa'" do
        @first_event.event_type.program.should == "el programa"
      end
      
      it "Should have 'Raul Gorgonzola' as trainer" do
        @first_event.trainer.name.should == "Raul Gorgonzola"
      end
      
      it "Should have 'Raul Gorgonzola' as trainer" do
        @first_event.trainer.bio.should == "Agile Coach"
      end
      
    end
  
  end

  context "When loading the testing XML source filtering by country" do
    before(:each) do  
      @connector = double("KeventerConnector")
      @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/events.xml') )

      @kevr = KeventerReader.new( @connector )
    end

    it "Filtering for all countries should return 16 events" do
      @kevr.commercial_events_by_country("todos").count.should == 16
    end
    
    it "Filtering for Argentina should return 8 events plus 3 Webinars" do
      @kevr.commercial_events_by_country("ar").count.should == 8+3
    end
    
    it "Filtering for Mexico should return no events and 3 Webinars" do
      @kevr.commercial_events_by_country("mx").count.should == 0+3
    end
    
    it "Filtering for Bolivia should return 3 events and 3 Webinars" do
      @kevr.commercial_events_by_country("bo").count.should == 3+3
    end
    
    it "Filtering for Colombia should return 1 event and 3 Webinars" do
      @kevr.commercial_events_by_country("co").count.should == 1+3
    end
    
    it "Filtering for Peru should return 1 event and 3 Webinars" do
      @kevr.commercial_events_by_country("pe").count.should == 1+3
    end
    
    it "Filtering for Otro should return no events" do
      @kevr.commercial_events_by_country("otro").count.should == 0
    end
    
  end

  context "Extracting countries out of events lists" do
    before(:each) do
      @connector = double("KeventerConnector")
      @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/events.xml') )
      @connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/community_events.xml') )

      @kevr = KeventerReader.new( @connector )
    end

    it "Should return 5 countries for commercial events" do
      @kevr.unique_countries_for_commercial_events().count.should == 5
    end
    
    it "Should return 2 countries for community events" do
      @kevr.unique_countries_for_community_events().count.should == 2
    end
   
    it "First country should be Argentina" do
      @kevr.unique_countries_for_commercial_events()[0].iso_code.should == "ar"
    end

    it "Second country should be Bolivia" do
      @kevr.unique_countries_for_commercial_events()[1].iso_code.should == "bo"
    end

    it "Last country should be Online" do
      @kevr.unique_countries_for_commercial_events()[4].iso_code.should == "ol"
    end
  end
  
  context "Extracting kleerers" do
    before(:each) do
      @connector = double("KeventerConnector")
      @connector.stub(:kleerers_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/kleerers.xml') )

      @kevr = KeventerReader.new( @connector )
    end

    it "should return 9 kleerers" do
      @kevr.kleerers.count.should == 9
    end

  end  
  
  context "Extracting Categories" do
    before(:each) do
      @connector = double("KeventerConnector")
      @connector.stub(:categories_xml_url).and_return( File.join(File.dirname(__FILE__),'../spec/categories.xml') )

      @kevr = KeventerReader.new( @connector )
      @high_performance = @kevr.category("high-performance")
    end

    it "should return 2 categories" do
      @kevr.categories.count.should == 2
    end

    it "should return the category 'high-performance' by id" do
      @high_performance.name.should == "High Performance"
    end

    it "should return nil for an unknown category" do
      @kevr.category("chiste-bueno-peix").should == nil
    end

    it "should get tagline for the category 'high-performance'" do
      @high_performance.tagline.should == "Personas, Equipos y Organizaciones Eficientes"
    end

    it "should get the description for the category 'high-performance'" do
      @high_performance.description.should == "una descripción..."
    end

    it "should get one event type for the category 'high-performance'" do
      @high_performance.event_types.count.should == 1
    end

    it "should get Tipo de Evento de Prueba for the category 'high-performance'" do
      @high_performance.event_types[0].name.should == "Tipo de Evento de Prueba"
      @high_performance.event_types[0].description.should == "Una descripción"
    end

  end
  
end
