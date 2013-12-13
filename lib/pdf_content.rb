#!/bin/env ruby
# encoding: utf-8
require "prawn"
require "prawn/measurement_extensions"

def content

  @category = @@keventer_reader.category("organizaciones")
  @event_types = @category.event_types

  @event_types.each_with_index do |event_type, index|

    @pdf.bounding_box [15.mm,250.mm], :width => 120.mm do

      @pdf.font( "res/Dosis-Regular.ttf", :size => 24 ) do
        @pdf.text event_type.name
        @pdf.text ""
      end

      @pdf.font( "res/Dosis-Regular.ttf", :size => 12 ) do
        @pdf.text event_type.elevator_pitch
      end
    end

    @pdf.fill_color = "faf863"
    @pdf.fill_rectangle [140.mm, 250.mm], 50.mm, 230.mm
    @pdf.fill_color = "000000"

    @pdf.bounding_box [145.mm,245.mm], :width => 40.mm do
      @pdf.font( "res/Dosis-Regular.ttf", :size => 12 ) do
        @pdf.text @category.name
      end
    end

    @pdf.start_new_page
  end
end

