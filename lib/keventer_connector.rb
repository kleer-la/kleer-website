class KeventerConnector
  
  API_ROOT = "http://keventer.herokuapp.com/api"
  API_EVENTS_PATH = "/events.xml"
  API_COMMUNITY_EVENTS_PATH = "/community_events.xml"
  API_KLEERERS_PATH = "/kleerers.xml"
  
  def events_xml_url
      API_ROOT + API_EVENTS_PATH
  end
  
  def community_events_xml_url
      API_ROOT + API_COMMUNITY_EVENTS_PATH
  end
  
  def kleerers_xml_url
    API_ROOT + API_KLEERERS_PATH
  end
  
end