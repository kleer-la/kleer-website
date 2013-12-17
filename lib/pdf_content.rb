#!/bin/env ruby
# encoding: utf-8
require "prawn"
require "prawn/measurement_extensions"

def content( category )

  @category = @@keventer_reader.category( category )
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

      # Duración desactivada hasta que unifiquemos criterios
      #
      # @pdf.text cuanto_dura(event_type.duration), 
      #   :size => 10, :align => :right
      # @pdf.move_up 5.mm
      @pdf.text event_type.name, :size => 12
      @pdf.text event_type.elevator_pitch, :size => 10

      @pdf.move_down 4.mm
    end
  end

  @pdf.start_new_page
end

def cuanto_dura(numero)
  return "" if numero.zero?
  return "1 día" if numero == 1
  return "#{numero} días" if numero < 6
  "#{numero} horas"
end
