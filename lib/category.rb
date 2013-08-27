class Category
  
  attr_accessor :name, :description, :tagline, :codename, :order, :event_types
  
  def initialize
    @name = ""
    @description = ""
    @tagline = ""
    @codename = ""
    @order = 0
    @event_types = []
  end
  
end