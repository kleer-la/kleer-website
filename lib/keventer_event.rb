class KeventerEvent
    attr_accessor :capacity, :city, :country, :country_code, :event_type, :date,
                  :finish_date, :registration_link, :is_sold_out, :id, :uri_path,
                  :trainer, :trainer2, :trainers, :keventer_connector, :place, :sepyme_enabled,
                  :human_date, :start_time, :end_time, :address, :list_price,
                  :eb_price, :eb_end_date, :currency_iso_code, :is_webinar,
                  :specific_conditions, :is_community_event, :time_zone_name,
                  :time_zone, :show_pricing, :couples_eb_price, :business_eb_price,
                  :business_price, :enterprise_6plus_price, :enterprise_11plus_price,
                  :mode

  def initialize
    @capacity = 0
    @city = ""
    @place = ""
    @country = ""
    @country_code = ""
    @event_type = nil
    @date = nil
    @finish_date = nil
    @start_time = nil
    @end_time = nil
    @is_sold_out = false
    @sepyme_enabled = false
    @registration_link = ""
    @id = 0
    @trainer = nil
    @trainer2 = nil
    @uri_path
    @keventer_connector = nil
    @human_date
    @address = ""

    @show_pricing = false
    @list_price = 0.0
    @eb_price = 0.0
    @eb_end_date = nil
    @couples_eb_price = 0.0
    @business_eb_price = 0.0
    @business_price = 0.0
    @enterprise_6plus_price = 0.0
    @enterprise_11plus_price = 0.0
    @currency_iso_code = ""

    @is_webinar = false
    @time_zone_name = ""
    @time_zone = nil

    @specific_conditions = ""
    @is_community_event = false
    @mode = ""
  end

  def is_online
    self.mode == "ol"
  end

  def is_classroom
    self.mode == "cl"
  end

  def is_blended_learning
    self.mode == "bl"
  end

  def discount
    if @eb_price.nil? || @eb_price == 0.0 || @list_price.nil? || @list_price == 0.0
      0.0
    else
      @list_price - @eb_price
    end
  end

  def uri_path
    uri_path_to_return = @id.to_s
    uri_event_type_name = @event_type.name.downcase
    uri_path_to_return += "-" + uri_event_type_name.gsub(/ /, "-")
    uri_city = @city.downcase
    uri_path_to_return += "-" + uri_city.gsub(/ /, "-")
    uri_path_to_return
  end

  def friendly_title
    @event_type.name + " - " + @city
  end

  def to_s
    @id
  end

  def add_trainer(trainer)
    @trainer = trainer
  end

  def trainers
    t= []
    if !@trainer.nil?
      t <<= @trainer
    end
    if !@trainer2.nil?
      t <<= @trainer2
    end
    t
  end

  def load(event_doc)
    load_descripcion(event_doc)
    load_date(event_doc)
    load_details(event_doc)
    load_status(event_doc)
    load_price(event_doc)
  end
  def load_descripcion(event_doc)
    @id = event_doc.find_first('id').content.to_i
    @capacity = event_doc.find_first('capacity').content.to_i
    @city = event_doc.find_first('city').content
    @place = event_doc.find_first('place').content
    @address = event_doc.find_first('address').content
    @registration_link = event_doc.find_first('registration-link').content

    @country = event_doc.find_first('country/name').content
    @country_code = event_doc.find_first('country/iso-code').content
    @currency_iso_code = event_doc.find_first('currency-iso-code').content
  end
  def load_date(event_doc)
    @date = Date.parse( event_doc.find_first('date').content )
    @finish_date = validated_Date_parse(event_doc.find_first('finish-date'))
    @start_time = DateTime.parse( event_doc.find_first('start-time').content )
    @end_time = DateTime.parse( event_doc.find_first('end-time').content )
  end

  def load_details(event_doc)
    @specific_conditions = event_doc.find_first('specific-conditions').content
    @is_community_event = event_doc.find_first('visibility-type').content == 'co'
    @mode = event_doc.find_first('mode').content
    @is_webinar = to_boolean( event_doc.find_first('is-webinar').content )
  end

  def load_status(event_doc)
    @is_sold_out = to_boolean( event_doc.find_first('is-sold-out').content )
  end

  def load_price(event_doc)
    @show_pricing = to_boolean( event_doc.find_first('show-pricing').content )
    @list_price = event_doc.find_first('list-price').content.nil? ? 0.0 : event_doc.find_first('list-price').content.to_f
    @eb_price = event_doc.find_first('eb-price').content.nil? ? 0.0 : event_doc.find_first('eb-price').content.to_f
    if @eb_price > 0.0
        @eb_end_date = validated_Date_parse(event_doc.find_first('eb-end-date'))
    end
    @couples_eb_price = event_doc.find_first('couples-eb-price').content.nil? ? 0.0 : event_doc.find_first('couples-eb-price').content.to_f
    @business_eb_price = event_doc.find_first('business-eb-price').content.nil? ? 0.0 : event_doc.find_first('business-eb-price').content.to_f
    @business_price = event_doc.find_first('business-price').content.nil? ? 0.0 : event_doc.find_first('business-price').content.to_f
    @enterprise_6plus_price = event_doc.find_first('enterprise-6plus-price').content.nil? ? 0.0 : event_doc.find_first('enterprise-6plus-price').content.to_f
    @enterprise_11plus_price = event_doc.find_first('enterprise-11plus-price').content.nil? ? 0.0 : event_doc.find_first('enterprise-11plus-price').content.to_f

  end

end
