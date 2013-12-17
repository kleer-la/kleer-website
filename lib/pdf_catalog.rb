#!/bin/env ruby
# encoding: utf-8
require "prawn"
require "prawn/measurement_extensions"

require_relative "pdf_cover"
require_relative "pdf_content"
require_relative "pdf_trainers"
require_relative "pdf_back_cover"

def pdf_catalog

	Prawn::Document.generate(
    "public/kleerCatalog.pdf",
    :page_size => "A4",
    :page_layout => :portrait,
    :margin => 5.mm ) do |pdf|

    @pdf = pdf
    
    cover

    ["organizaciones", "clientes", "productos"].each do |category|
        content(category)
    end

    # trainers

    back_cover
	end
end







