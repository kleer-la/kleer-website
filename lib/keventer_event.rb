class KeventerEvent
    attr_accessor :capacity, :city, :country, :country_code, :event_type, :date, :registration_link, :is_sold_out, :id, :uri_path, :trainer
  
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
    @trainer = nil
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
  
  def friendly_title
    @event_type.name + " - " + @city
  end
  
  def to_s
    @id
  end
  
  def trainer_name
    warn "[DEPRECATION] 'trainer_name' is deprecated.  Please use 'trainer.name' instead."
    @trainer.name
  end
  
  def trainer_bio
    warn "[DEPRECATION] 'trainer_bio' is deprecated.  Please use 'trainer.bio' instead."
    @trainer.bio
  end
  
end