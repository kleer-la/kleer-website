class KeventerEventType
  attr_accessor :name, :goal, :description, :recipients, :program, :duration, :faqs, :elevator_pitch, :learnings, :takeaways
  
  def initialize
    @name = ""
    @goal = ""
    @description = ""
    @recipients = ""
    @program = ""
    @faqs = ""
    @duration = 0
    @elevator_pitch = ""
    @learnings = ""
    @takeaways = ""
  end
end