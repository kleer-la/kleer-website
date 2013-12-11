require "prawn"
require "prawn/measurement_extensions"

def pdf_catalog

	@category = @@keventer_reader.category("organizaciones")
	@event_types = @category.event_types

	Prawn::Document.generate(
    "public/kleerCatalog.pdf",
    :page_size => "A4",
    :page_layout => :portrait,
    :margin => 5.mm ) do |pdf|

    pdf.fill_color = "80e2ff"
    pdf.fill_rectangle [0.mm, 287.mm], 200.mm, 287.mm
    pdf.fill_color = "000000"

    pdf.font( "lib/Dosis-Regular.ttf", :size => 36 ) do
      pdf.text created_on
    end
  
    pdf.start_new_page

    pdf.text "Pagina 2"

	end

end



def created_on
  today = DateTime.now
  "Generado en Kleer Ediciones el #{today.strftime("%d")}"\
    " de #{DTHelper::MONTHS_ES[today.strftime("%b")]}"\
    " de #{today.strftime("%Y")}"\
    " a las #{today.strftime("%I")}"\
    ":#{today.strftime("%M")}"\
    "#{today.strftime("%P")}"
end