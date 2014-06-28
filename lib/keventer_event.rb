class KeventerEvent
    attr_accessor :capacity, :city, :country, :country_code, :event_type, :date, :finish_date, :registration_link, 
                  :is_sold_out, :id, :uri_path, :trainer, :keventer_connector, :place, :sepyme_enabled,
                  :human_date, :start_time, :end_time, :address, :list_price, :eb_price, :eb_end_date, 
                  :currency_iso_code, :is_webinar, :specific_conditions, :is_community_event, 
                  :time_zone_name, :time_zone
  
  def initialize
    @capacity = 0
    @city = ""
    @place = ""
    @country = ""
    @country_code = ""
    @event_type = nil
    @date = nil
    @finish_date = nil
    @start_time = nil
    @end_time = nil
    @is_sold_out = false
    @sepyme_enabled = false
    @registration_link = ""
    @id = 0
    @trainer = nil
    @uri_path
    @keventer_connector = nil
    @human_date
    @address = ""
    @list_price = 0.0
    @eb_price = 0.0
    @eb_end_date = nil
    @currency_iso_code = ""

    @is_webinar = false
    @time_zone_name = ""
    @time_zone = nil

    @specific_conditions = ""
    @is_community_event = false
  end
  
  def discount
    if @eb_price.nil? || @eb_price == 0.0 || @list_price.nil? || @list_price == 0.0
      0.0
    else
      @list_price - @eb_price
    end
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