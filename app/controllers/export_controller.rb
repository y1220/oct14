#require 'carrierwave/orm/activerecord'
#require 'mimemagic'
class ExportController < ApplicationController
   
    
    def show
        respond_to do |format|
          # some other formats like: format.html { render :show }
          format.pdf do
            pdf = ExportPdf.new
            @meal= Meal.find_by(id: params[:id])
            pdf.text "user name: "+ @current_user.name, :color => "0000ff", :size => 32
            pdf.text "chef: "+ @meal.user.name, :size => 28
            pdf.text "recipe title: "+ @meal.title, :size => 28
            pdf.text "content: "+ @meal.content, :size => 28, :style => :nerko
            if @meal.image.present? 
                #pdf.image  Rails.public_path.join("collections_images/meal/smile.png")
                #pdf.image "#{@meal.image}"
                #pdf.image Rails.public_path.join("31.jpg")
                pdf.image  Rails.root.join("public#{@meal.image}"), :at => [50,550], :width => 450
            end
            send_data pdf.render,
              filename: "recipe.pdf",
              type: 'application/pdf',
              disposition: 'inline'
          end
        
        end
    end

    def receipt
        respond_to do |format|
            # some other formats like: format.html { render :show }
            
  
              
            format.pdf do
              pdf = ExportPdf.new
              @meal= Meal.find_by(id: params[:id])
              pdf.text "receipt\n"
              pdf.text "user name: "+ @current_user.name
              pdf.text "chef: "+ @meal.user.name
              pdf.text "recipe title: "+ @meal.title
              pdf.text "content: "+ @meal.content
              send_data pdf.render,
                filename: "receipt.pdf",
                type: 'application/pdf',
                disposition: 'inline'
            end
          
        end
    end
end
