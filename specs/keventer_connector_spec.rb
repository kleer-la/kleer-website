# encoding: utf-8
require File.join(File.dirname(__FILE__),'../lib/keventer_connector')

describe KeventerConnector do
  
  before(:each) do
    @kconn = KeventerConnector.new
  end
  
  it "should be able to return the default events xml path" do
    @kconn.events_xml_url.should == "http://keventer.herokuapp.com/api/events.xml"
  end
  
  it "should be able to return the default community events xml path" do
    @kconn.community_events_xml_url.should == "http://keventer.herokuapp.com/api/community_events.xml"
  end

  it "should be able to return the default kleerers xml path" do
    @kconn.kleerers_xml_url.should == "http://keventer.herokuapp.com/api/kleerers.xml"
  end

end