#!/bin/env ruby
# encoding: utf-8
require "prawn"
require "prawn/measurement_extensions"

def trainers

  @trainers = KeventerReader.instance.kleerers

  @pdf.font "res/Dosis-Regular.ttf"

  @pdf.fill_color = "75f276"
  @pdf.fill_rectangle [0.mm, 287.mm], 200.mm, 17.mm
  @pdf.fill_color = "000000"

  @pdf.bounding_box [15.mm,285.mm], :width => 170.mm do
    @pdf.text "Facilitadores de tu proceso de aprendizaje", :size => 24
  end

  @pdf.bounding_box [15.mm,265.mm], :width => 170.mm do

    @trainers.each_with_index do |trainer, index|

      y_position = @pdf.cursor
      @pdf.text trainers[0].name, :size => 12

      @pdf.image "public/img/icons/linkedin.png",
        :at => [50.mm,y_position], :width => 5.mm
      @pdf.draw_text trainers[0].linkedin_url,
        :size => 10, :at => [60.mm,y_position]

      @pdf.image "public/img/icons/twitter.png",
        :at => [100.mm,y_position], :width => 5.mm
      @pdf.draw_text trainers[0].twitter_username,
        :size => 10, :at => [110.mm, y_position]

      @pdf.text trainers[0].bio, :size => 10

      # .gravatar_picture_url

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
