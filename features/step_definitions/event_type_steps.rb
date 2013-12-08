#encoding: utf-8

require File.join(File.dirname(__FILE__),'../../lib/keventer_reader')

def stub_connector( test_file = "just_one_event.xml")
  connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/#{test_file}") )
  connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/community_events.xml") )
  connector.stub(:kleerers_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/kleerers.xml") )
  connector.stub(:categories_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/categories.xml") )
  
end

def get_event_type(event_type_id)
  connector = double("KeventerConnector")
  connector.should_receive(:event_type_url).with(event_type_id) #TODO: move to RSpec
  connector.stub(:event_type_url).and_return( File.join(File.dirname(__FILE__),"../../spec/event_type_#{event_type_id}.xml") )
  @@keventer_reader.connector = connector    
end

Given(/^theres an event type$/) do
    get_event_type(4)
end

When(/^I visit the plain event type page$/) do
  visit '/cursos/4-xxx'
end

Given(/^there are community event type$/) do
    get_event_type(19)
end

When(/^I visit the community event type page$/) do
  visit '/cursos/19-xxx'
end

When(/^I visit a non existing event type page$/) do
  connector = double("KeventerConnector")
  connector.should_receive(:event_type_url)
  connector.stub(:event_type_url).and_return( nil)
  @@keventer_reader.connector = connector    

  visit '/cursos/1-xxx'
end
