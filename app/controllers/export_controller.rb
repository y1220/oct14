class ExportController < ApplicationController
    def show
        respond_to do |format|
          # some other formats like: format.html { render :show }
    
          format.pdf do
            pdf = Prawn::Document.new
            @meal= Meal.find_by(id: params[:id])
            pdf.text "user name: "+ @current_user.name
            pdf.text "chef: "+ @meal.user.name
            pdf.text "recipe title: "+ @meal.title
            pdf.text "content: "+ @meal.content
            send_data pdf.render,
              filename: "export.pdf",
              type: 'application/pdf',
              disposition: 'inline'
          end
        end
    end
end
