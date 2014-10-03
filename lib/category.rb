class Category
  
  attr_accessor :name, :description, :tagline, :codename, :order, :event_types
  
  def initialize xml=nil, lang="es"
    suffix= lang =='en' ? "-en" : ""
    @codename = ""
    @order = 0
    @event_types = []
        
    if xml.nil?
        @name = ""
        @description = ""
        @tagline = ""
    else
        @name = xml.find_first('name'+suffix).content
        @codename = xml.find_first('codename').content
        @tagline = xml.find_first('tagline'+suffix).content
        @description = xml.find_first('description'+suffix).content
        @order = xml.find_first('order').content.to_i
    end
  end
  
end