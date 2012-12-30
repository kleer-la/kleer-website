class KeventerEvent
    attr_accessor :capacity, :city, :country, :country_code, :event_type, :date, :registration_link, :is_sold_out, :id, :trainer_name, :trainer_bio, :uri_path
  
  def initialize
    @capacity = 0
    @city = ""
    @country = ""
    @country_code = ""
    @event_type = nil
    @date = nil
    @is_sold_out = false
    @registration_link = ""
    @id = 0
    @trainer_name = ""
    @trainer_bio
    @uri_path
  end
  
  def uri_path
    uri_path_to_return = @id.to_s
    uri_event_type_name = @event_type.name.downcase
    uri_path_to_return += "-" + uri_event_type_name.gsub(/ /, "-")
    uri_city = @city.downcase
    uri_path_to_return += "-" + uri_city.gsub(/ /, "-")
    uri_path_to_return
  end
  
  def to_s
    @id
  end
end