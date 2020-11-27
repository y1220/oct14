class AdminController < ApplicationController

    #before_action :ensure_correct_user
    before_action :authenticate_user 
    before_action :check_admin
    before_action :allowed_params, {only: [:create_book]}
    
  
  
    def index
      @participants = Participant.all.order(created_at: :desc)
    end

    def success
    end

    def recipe_book
      @request = Request.new
      @meals= Meal.where(book: true)
    end

    def create_book
      #byebug
      arr= allowed_params[:pdfs]
      @book = Book.new(title: allowed_params[:title])
      @book.save
      #pdf_file_names  = []#["pasta.pdf","pizza.pdf"]
      pdf_meals = [] #array of meals (object)

      arr.count.times{ |i|
        @mealbook= MealBook.new(meal_id: arr[i],book_id: @book.id)
        #pdf_file_names << "#{Meal.find(arr[i]).title}.pdf"
        pdf_meals << Meal.find(arr[i])
        @mealbook.save
      }
      
      pdf_file_paths  = pdf_meals.map! do |meal|
        meal_type= MealType.find(meal.meal_type)
        Rails.root.join("app/pdfs/#{meal_type.description}/#{meal.title}.pdf")
      end

      @pdfForms = CombinePDF.new
      pdf_file_paths.each do |path|
        @pdfForms << CombinePDF.load(path) #path is relative path to pdf file stored locally like path/to/801.pdf
      end
      @pdfForms.number_pages
      @pdfForms.save "recipe_book/#{@book.title}.pdf"
      if !@mealbook.nil?
        flash[:notice]= "New book created successfully!"
        redirect_to admin_success_url
      else
        flash[:notice]= "Inserted account doesn't exist..try again!"
        render("admin/recipe_book")
      end
    end
  
    
    def check_admin
        unless @current_user.role == "admin"
          redirect_to("/users/upgrade")
        end
    end

    def set_current_user
        @current_user= User.find_by(id: session[:user_id])
    end

    private  ## has to be the bottom of the page not to let other method as private one
    def show_error (error_message, return_to_address)
      flash[:notice]= error_message
      render(return_to_address)
    end

    def allowed_params
      params.require(:request)#.
        #permit(:pdfs,:title)
    end

    
end
