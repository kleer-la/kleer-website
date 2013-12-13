#!/bin/env ruby
# encoding: utf-8
require "prawn"
require "prawn/measurement_extensions"

def cover
    @pdf.fill_color = "80e2ff"
    @pdf.fill_rectangle [0.mm, 287.mm], 200.mm, 287.mm
    @pdf.fill_color = "000000"

    # Logo y Título
    @pdf.bounding_box [20.mm,250.mm], :width => 150.mm, :height => 100.mm do

      @pdf.image "res/Logo_Kleer_GrisBlanco.png", :width => 60.mm

      @pdf.font( "res/Dosis-Regular.ttf", :size => 36 ) do
        @pdf.text "\n\nCATALOGO DE\nENTRENAMIENTO"
      end
    end

    # Pie de imprenta
    @pdf.bounding_box [20.mm,15.mm], :width => 150.mm, :height => 15.mm do

      @pdf.font( "res/Dosis-Regular.ttf", :size => 12 ) do
        @pdf.text created_on
      end
    end

    @pdf.start_new_page
end

def created_on
  today = DateTime.now
  "Generado el #{today.strftime("%d")}"\
    " de #{DTHelper::MONTHS_ES[today.strftime("%b")]}"\
    " de #{today.strftime("%Y")}"\
    " a las #{today.strftime("%I")}"\
    ":#{today.strftime("%M")}"\
    "#{today.strftime("%P")}"
end