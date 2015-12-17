class KeventerEventType
  attr_accessor :id, :name, :subtitle, :goal, :description, :recipients, :program, :duration, :faqs,
                :elevator_pitch, :learnings, :takeaways, :elevator_pitch, :include_in_catalog,
                :public_editions, :average_rating, :net_promoter_score, :surveyed_count,
                :promoter_count

  def initialize
    @id = nil
    @name = ""
    @subtitle= ""
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

  def load_string(xml, field)
    element= xml.find_first(field.to_s)
    if not element.nil?
      send(field.to_s+"=", element.content)
    end
  end

  def load(xml_keventer_event)
    @id  = xml_keventer_event.find_first('id').content.to_i
    @duration = xml_keventer_event.find_first('duration').content.to_i

    [:name, :subtitle, :description, :learnings, :takeaways,
      :goal, :recipients, :program].each {
      |f| load_string(xml_keventer_event, f)
    }

    @faqs  = xml_keventer_event.find_first('faq').content
    @elevator_pitch = xml_keventer_event.find_first('elevator-pitch').content
    @include_in_catalog = to_boolean( xml_keventer_event.find_first('include-in-catalog').content )

    @average_rating = xml_keventer_event.find_first('average-rating').content.nil? ? nil : xml_keventer_event.find_first('average-rating').content.to_f.round(2)
    @net_promoter_score = xml_keventer_event.find_first('net-promoter-score').content.nil? ? nil : xml_keventer_event.find_first('net-promoter-score').content.to_i
    @surveyed_count = xml_keventer_event.find_first('surveyed-count').content.to_i
    @promoter_count = xml_keventer_event.find_first('promoter-count').content.to_i
  end


end
