# encoding: utf-8
require File.join(File.dirname(__FILE__),'../lib/keventer_reader')
require 'date'

describe KeventerReader do
  
  it "Should Be Able to Load an Xml File for Events" do
    @kevr = KeventerReader.new( File.join(File.dirname(__FILE__),'../specs/events.xml') )
    @kevr.events.count.should == 16   
  end
  
  it "Should Be Able to Load an Xml URI for Events" do
    @kevr = KeventerReader.new( "http://keventer-test.herokuapp.com/api/events.xml" )
    @kevr.events.count.should >= 0
  end
  
  context "When loading the teasting XML source with 16 events" do
    
    before(:each) do
      @kevr = KeventerReader.new( File.join(File.dirname(__FILE__),'../specs/events.xml'))
    end
   
    it "Should allow access to an events array with all events" do
      @kevr.events.count.should == 16   
    end
    
    it "Should allow access to an events array for the next two months" do
      from = Date.parse("2012-12-20")
      @kevr.coming_events(from).count.should == 8
    end
    
    it "should be able to fetch a certain event" do
      @kevr.event(44).event_type.name.should == "Workshop de Retrospectivas"
    end
    
    it "should be able to fetch a certain event if the parameter is a string" do
      @kevr.event("44").event_type.name.should == "Workshop de Retrospectivas"
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
  
end
