class KeventerEventType
  attr_accessor :id, :name, :goal, :description, :recipients, :program, :duration, :faqs, 
                :elevator_pitch, :learnings, :takeaways, :elevator_pitch, :include_in_catalog, 
                :public_editions, :average_rating, :net_promoter_score, :surveyed_count,
                :promoter_count
  
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
    @include_in_catalog = false
    @public_editions = Array.new

    @average_rating = 0.0
    @net_promoter_score = 0
    @surveyed_count = 0
    @promoter_count = 0
  end
  
  def uri_path
    @id.to_s + "-" + @name.downcase.gsub(/ /, "-")
  end
  
  def has_rate
    surveyed_count > 20 && !average_rating.nil?
  end
end