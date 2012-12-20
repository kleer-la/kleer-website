class KeventerEventType
  attr_accessor :name, :goal, :description, :recipients, :program, :duration
  
  def initialize
    @name = ""
    @goal = ""
    @description = ""
    @recipients = ""
    @program = ""
    @duration = 0
  end
end