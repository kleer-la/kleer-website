require File.join(File.dirname(__FILE__),'../lib/keventer_event')
require File.join(File.dirname(__FILE__),'../lib/professional')

describe KeventerEvent do
  
  before(:each) do
    @kevent = KeventerEvent.new
  end

  it "should have an id" do
    @kevent.id = 10
    @kevent.id.should == 10
  end
  
  it "should have a keventer connector" do
    kc = KeventerConnector.new
    @kevent.keventer_connector = kc
    @kevent.keventer_connector.should == kc
  end  
  
  it "should have a capacity" do
    @kevent.capacity = 10
    @kevent.capacity.should == 10
  end
  
  it "should have a date" do
    a_date = Date.new
    @kevent.date = a_date
    @kevent.date.should == a_date
  end
  
  it "should have a start time" do
    a_time = Time.new
    @kevent.start_time = a_time
    @kevent.start_time.should == a_time
  end
  
  it "should have an end time" do
    a_time = Time.new
    @kevent.end_time = a_time
    @kevent.end_time.should == a_time
  end
  
  it "should have a human date" do
    @kevent.human_date = "18-19 Abr"
    @kevent.human_date.should == "18-19 Abr"
  end  
  
  it "should have a registration_link" do
    @kevent.registration_link = "http://kleer.la"
    @kevent.registration_link.should == "http://kleer.la"
  end
  
  it "should have an address" do
    @kevent.address = "http://kleer.la"
    @kevent.address.should == "http://kleer.la"
  end
  
  it "should have a sold-out flag" do
    @kevent.is_sold_out = false
    @kevent.is_sold_out.should == false
  end
  
  it "should have a sepyme_enabled flag" do
    @kevent.sepyme_enabled = false
    @kevent.sepyme_enabled.should == false
  end  
  
  it "should have a place" do
    @kevent.place = "Kleer, Tucuman 373 1er Piso"
    @kevent.place.should == "Kleer, Tucuman 373 1er Piso"
  end
  
  it "should have a city" do
    @kevent.city = "Buenos Aires"
    @kevent.city.should == "Buenos Aires"
  end
  
  it "should have a country" do
    @kevent.country = "Argentina"
    @kevent.country.should == "Argentina"
  end
  
  it "should have a country_code" do
    @kevent.country_code = "ar"
    @kevent.country_code.should == "ar"
  end
  
  it "should have an event type" do
      an_event_type = KeventerEventType.new
      @kevent.event_type = an_event_type
      @kevent.event_type.should == an_event_type
  end
  
  it "should have a list_price" do
    @kevent.list_price = 12.0
    @kevent.list_price.should == 12.0
  end
  
  it "should have a eb_price" do
    @kevent.eb_price = 12.0
    @kevent.eb_price.should == 12.0
  end
  
  it "should have a discount" do
    @kevent.list_price = 12.0
    @kevent.eb_price = 10.5
    @kevent.discount.should == 1.5
  end
  
  it "should have a discount" do
    @kevent.list_price = 12.0
    @kevent.eb_price = 0.0
    @kevent.discount.should == 0.0
  end
  
  it "should have a discount" do
    @kevent.list_price = 12.0
    @kevent.eb_price = nil
    @kevent.discount.should == 0.0
  end
  
  it "should have a eb_end_date" do
    a_date = Date.new
    @kevent.eb_end_date = a_date
    @kevent.eb_end_date.should == a_date
  end
  
  it "should have a currency_iso_code" do
    @kevent.currency_iso_code = "ARS"
    @kevent.currency_iso_code.should == "ARS"
  end

  it "should have specific_conditions" do
    @kevent.specific_conditions = "Condiciones Especiales de Evento"
    @kevent.specific_conditions.should == "Condiciones Especiales de Evento"
  end

  context "If the trainer is Raul Gorgonzola" do
    
    before(:each) do
      @trainer = Professional.new
      @trainer.name = "Raul Gorgonzola"
      @trainer.bio = "hg jgjhagsdjhagsdkjahgsfkjahgsj ja sfkjahs fkjahsfg"
  
      @kevent.trainer = @trainer
    end

    it "should have a trainer" do
        @kevent.trainer.should == @trainer
    end
  
    it "should have a deprecated trainer name backward compatible" do
        @kevent.should_receive(:warn).with("[DEPRECATION] 'trainer_name' is deprecated.  Please use 'trainer.name' instead.")
        @kevent.trainer_name.should == @trainer.name
    end
  
    it "should have a trainer bio backward compatible" do
        @kevent.should_receive(:warn).with("[DEPRECATION] 'trainer_bio' is deprecated.  Please use 'trainer.bio' instead.")
        @kevent.trainer_bio.should ==@trainer.bio
    end
  
  end
  
  it "should form the uri path automatically" do
    @kevent.id = 44
    an_event_type = KeventerEventType.new
    an_event_type.name = "Workshop de Retrospectivas"
    @kevent.event_type = an_event_type
    @kevent.city = "Buenos Aires"
    @kevent.uri_path.should == "44-workshop-de-retrospectivas-buenos-aires"
  end
  
  
  it "should form the friendly title automatically" do
    @kevent.id = 44
    an_event_type = KeventerEventType.new
    an_event_type.name = "Workshop de Retrospectivas"
    @kevent.event_type = an_event_type
    @kevent.city = "Buenos Aires"
    @kevent.friendly_title.should == "Workshop de Retrospectivas - Buenos Aires"
  end

end