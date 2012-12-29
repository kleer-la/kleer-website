class KeventerEvent
    attr_accessor :capacity, :city, :country, :country_code, :event_type, :date, :registration_link, :is_sold_out, :id, :trainer_name
  
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
  end
  
  def to_s
    @id
  end
end