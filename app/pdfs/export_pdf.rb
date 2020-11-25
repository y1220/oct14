require 'carrierwave/orm/activerecord'
require 'mimemagic'

class ExportPdf
    include Prawn::View
    
  
    def initialize
      font_setup
      content
    end

    def font_setup
      font_families.update("Nerko_one" => {
        :nerko => "vendor/assets/fonts/NerkoOne-Regular.ttf",
        #:normal => "vendor/assets/fonts/Play-Bold.ttf"
        :normal => "vendor/assets/fonts/Play-Regular.ttf"
      })
      #font_families.update("NotoSans" => {
        #:normal => "vendor/assets/fonts/NotoSans-Regular.ttf",
        #:italic => "vendor/assets/fonts/NotoSans-Italic.ttf",
        #:bold => "vendor/assets/fonts/NotoSans-Bold.ttf",
      #})
      font "Nerko_one"
    end
  
    def content
      text "printed at: "+ Time.new.strftime("%Y-%m-%d %H:%M:%S"), :align => :right
      text "\n"
    end
end