#!/bin/env ruby
# encoding: utf-8
require "prawn"
require "prawn/measurement_extensions"

require_relative "pdf_cover"
require_relative "pdf_back_cover"
require_relative "pdf_content"

def pdf_catalog

	Prawn::Document.generate(
    "public/kleerCatalog.pdf",
    :page_size => "A4",
    :page_layout => :portrait,
    :margin => 5.mm ) do |pdf|

    @pdf = pdf

    cover

    content

    back_cover
	end
end







