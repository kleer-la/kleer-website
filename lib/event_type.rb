# encoding: utf-8

class EventType
  
  attr_accessor :id, :name, :description, :elevator_pitch
  
  def initialize
    @id = ""
    @name = ""
    @description = ""
    @elevator_pitch = ""

      #   <created-at type="datetime">2013-07-10T20:48:22Z</created-at>
      #   <duration type="integer">8</duration>
      #   <faq></faq>
      #   <goal>Un objetivo</goal>
      #   <id type="integer">1</id>
      #   <include-in-catalog type="boolean">true</include-in-catalog>
      #   <materials></materials>
      #   <program>El programa</program>
      #   <recipients>Un destinatario</recipients>
      #   <updated-at type="datetime">2013-07-10T20:54:21Z</updated-at>
      # </event-type>
  end
  
  def uri_path
    @id.to_s + "-" + @name.downcase.gsub(/ /, "-")
  end
  
end