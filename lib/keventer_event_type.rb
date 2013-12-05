class KeventerEventType
  attr_accessor :id, :name, :goal, :description, :recipients, :program, :duration, :faqs, :elevator_pitch, :learnings, :takeaways, :elevator_pitch
  
  def initialize
    @id = nil
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
  
  def uri_path
    @id.to_s + "-" + @name.downcase.gsub(/ /, "-")
  end
  
end