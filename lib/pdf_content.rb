#!/bin/env ruby
# encoding: utf-8
require "prawn"
require "prawn/measurement_extensions"

def content( category )

  @category = KeventerReader.instance.category( category )
  @event_types = @category.event_types

  @pdf.font "res/Dosis-Regular.ttf"

  @pdf.fill_color = "faf863"
  @pdf.fill_rectangle [0.mm, 287.mm], 200.mm, 17.mm
  @pdf.fill_color = "000000"

  @pdf.bounding_box [15.mm,285.mm], :width => 170.mm do
    @pdf.text @category.name, :size => 24
  end

  @pdf.bounding_box [15.mm,265.mm], :width => 170.mm do

    @event_types.each_with_index do |event_type, index|

      # Group automatically handles keeping different text areas on the same page
      @pdf.group do
        @pdf.text "<link href='#{full_uri(event_type)}'>#{event_type.name}</link>",
          :size => 12,
          :inline_format => true

        @pdf.text event_type.elevator_pitch, :size => 10

        @pdf.move_down 4.mm
      end
    end
  end

  @pdf.start_new_page
end

def full_uri( workshop )
  "http://www.kleer.la/es/categoria/#{@category.codename}/cursos/#{url_sanitize(workshop.uri_path)}"
end
