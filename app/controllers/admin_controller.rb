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
      arr.count.times{ |i|
        @mealbook= MealBook.new(meal_id: arr[i],book_id: @book.id)
        @mealbook.save
      }
      if !@mealbook.nil?
        flash[:notice]= "New book created successfully!"
        redirect_to("/meals")
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
