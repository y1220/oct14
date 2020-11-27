#require 'carrierwave/orm/activerecord'
#require 'mimemagic'
class ExportController < ApplicationController


   
    def multiply
      pdf_file_names  = ["pasta.pdf","pizza.pdf"]
      pdf_file_paths  = pdf_file_names.map! do |x|
        Rails.root.join("app/pdfs/main_dish/#{x}")
      end

      @pdfForms = CombinePDF.new
      pdf_file_paths.each do |path|
        @pdfForms << CombinePDF.load(path) #path is relative path to pdf file stored locally like path/to/801.pdf
      end
      @pdfForms.number_pages
      @pdfForms.save "n_combined.pdf"

      flash[:notice] = "Combined PDF successful"
      redirect_to admin_success_url
    end

    
   
    
    def folder
        respond_to do |format|
          # some other formats like: format.html { render :show }
          format.pdf do
            pdf = ExportPdf.new
            @meal= Meal.find_by(id: params[:id])
            #pdf.text "user name: "+ @current_user.name, :color => "0000ff", :size => 32
            pdf.text "chef: "+ @meal.user.name, :size => 28
            pdf.text "recipe title: "+ @meal.title, :size => 28
            pdf.text "content: "+ @meal.content, :size => 28, :style => :nerko
            if @meal.image.present? 
                #pdf.image  Rails.public_path.join("collections_images/meal/smile.png")
                #pdf.image "#{@meal.image}"
                #pdf.image Rails.public_path.join("31.jpg")
                pdf.image  Rails.root.join("public#{@meal.image}"), :at => [50,550], :width => 450
            end
            #send_data pdf.render,
            @mealType= MealType.find_by(id: @meal.meal_type)
            @meal.book=true
            @meal.save
            pdf.render_file "#{Rails.root}/app/pdfs/#{@mealType.description}/#{@meal.title}.pdf"
            flash[:notice] = "PDF genarated in a folder"
            #filename: "recipe.pdf",
              #type: 'application/pdf',
              #disposition: 'inline'
          end
        
        end
    end

    def download
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
          #@mealType= MealType.find_by(id: @meal.meal_type)
          #pdf.render_file "#{Rails.root}/app/pdfs/#{@mealType.description}/#{@meal.title}.pdf"
          #flash[:notice] = "PDF genarated in a folder"
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
