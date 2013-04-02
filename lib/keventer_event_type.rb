class KeventerEventType
  attr_accessor :name, :goal, :description, :recipients, :program, :duration, :faqs
  
  def initialize
    @name = ""
    @goal = ""
    @description = ""
    @recipients = ""
    @program = ""
    @faqs = ""
    @duration = 0
  end
end