require File.join(File.dirname(__FILE__),'../../lib/keventer_reader')

def stub_connector( comercial_events = "just_one_event.xml")
  connector = double("KeventerConnector")
  connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/#{comercial_events}") )
  connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/community_events.xml") )
  connector.stub(:kleerers_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/kleerers.xml") )
  connector.stub(:categories_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/categories.xml") )

  KeventerReader.build_with( connector )
end

def stub_connector_community(community_events)
  connector = double("KeventerConnector")
  connector.stub(:events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/just_one_event.xml") )
  connector.stub(:community_events_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/#{community_events}") )
  connector.stub(:kleerers_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/kleerers.xml") )
  connector.stub(:categories_xml_url).and_return( File.join(File.dirname(__FILE__),"../../spec/categories.xml") )
  KeventerReader.build_with( connector )
end
