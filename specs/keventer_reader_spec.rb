# encoding: utf-8
require File.join(File.dirname(__FILE__),'../lib/keventer_reader')
require 'date'

describe KeventerReader do
  
  it "Should Be Able to Load an Xml File for Events" do
    @connector = double("KeventerConnector")
    @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/events.xml') )
    
    @kevr = KeventerReader.new( @connector )
    @kevr.events.count.should == 16   
  end
  
  it "Should Be Able to Load an Xml URI for Events" do
    @connector = double("KeventerConnector")
    @connector.stub(:events_xml_url).and_return( "http://keventer-test.herokuapp.com/api/events.xml" )
    
    @kevr = KeventerReader.new( @connector )
    @kevr.events.count.should >= 0
  end
  
  context "When loading the teasting XML source with 16 events" do
    
    before(:each) do
      @connector = double("KeventerConnector")
      @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/events.xml') )
      @connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/community_events.xml') )

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
        @first_event.trainer_name.should == "Raul Gorgonzola"
      end
      
      it "Should have 'Raul Gorgonzola' as trainer" do
        @first_event.trainer_bio.should == "Agile Coach"
      end
      
    end
  
  end

  context "When loading the testing XML source filtering by country" do
    before(:each) do  
      @connector = double("KeventerConnector")
      @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/events.xml') )

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
      @connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/events.xml') )
      @connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/community_events.xml') )

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
      @connector.stub(:kleerers_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/kleerers.xml') )

      @kevr = KeventerReader.new( @connector )
    end

    it "should return 9 kleerers" do
      @kevr.kleerers.count.should == 9
    end

  end  
  
  context "Extracting Categories" do
    before(:each) do
      @connector = double("KeventerConnector")
      @connector.stub(:categories_xml_url).and_return( File.join(File.dirname(__FILE__),'../specs/categories.xml') )

      @kevr = KeventerReader.new( @connector )
    end

    it "should return 3 categories" do
      @kevr.categories.count.should == 3
    end

    it "should return the category 'high-performance' by id" do
      @kevr.category("high-performance").name.should == "High Performance"
    end

    it "should return nil for an unknown category" do
      @kevr.category("chiste-bueno-peix").should == nil
    end

    it "should get tagline for the category 'high-performance'" do
      @kevr.category("high-performance").tagline.should == "Personas, Equipos y Organizaciones Eficientes"
    end

    it "should get the descriptionfor the category 'high-performance'" do
      @kevr.category("high-performance").description.should == "una descripción..."
    end

  end
  
end
