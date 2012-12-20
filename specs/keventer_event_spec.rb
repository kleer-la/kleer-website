require File.join(File.dirname(__FILE__),'../lib/keventer_event')

describe KeventerEvent do
  
  before(:each) do
    @kevent = KeventerEvent.new
  end

  it "should have an id" do
    @kevent.id = 10
    @kevent.id.should == 10
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
  
  it "should have a registration_link" do
    @kevent.registration_link = "http://kleer.la"
    @kevent.registration_link.should == "http://kleer.la"
  end
  
  it "should have a sold-out flag" do
    @kevent.is_sold_out = false
    @kevent.is_sold_out.should == false
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
  
  
end