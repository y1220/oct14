class ExportController < ApplicationController
    def show
        respond_to do |format|
          # some other formats like: format.html { render :show }
          

            
          format.pdf do
            pdf = ExportPdf.new
            @meal= Meal.find_by(id: params[:id])
            pdf.text "user name: "+ @current_user.name
            pdf.text "chef: "+ @meal.user.name
            pdf.text "recipe title: "+ @meal.title
            pdf.text "content: "+ @meal.content
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
