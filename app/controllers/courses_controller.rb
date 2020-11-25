class CoursesController < ApplicationController

  before_action :authenticate_user
  before_action :check_premium
  

  def index
    @courses = Course.all.order(created_at: :desc)
  end

  def thanks
    @course = Course.find_by(id: params[:id])
    @participant= @course.participants.create(user_id: @current_user.id)
    if @participant.save
      flash[:notice]= "You have enrolled to this course!"
      #redirect_to("/courses/#{@course.id}/thanks")
    else
      flash[:notice]= "something went wrong..try again!"
      @courses = Course.all.order(created_at: :desc)
      render("courses/index")
      #render("meals/#{params[:id]}")
    end
  end

  def new
    @course = Course.new
  end

  
  def create
    @course = Course.new(name: allowed_params["name"],
      description: allowed_params["description"], price: allowed_params["price"],
      user_id: @current_user.id)
    if @course.save
      flash[:notice]= "New course has been created successfully!"
      redirect_to("/courses")
    else
      show_error("Inserted id doesn't exist..try again!","courses/new")
    end

  end

  

  def edit
  end

  def show
    @course = Course.find_by(id: params[:id])
    @user = @course.user
  end

  def update
  end

  def destroy
  end

  private

  def check_premium
    if @current_user.role == "premium"
      return true
    else
      return false
    end
  end


  def allowed_params
    params.require(:course).
      permit(:name, :description, :price)
  end

  
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message 
    render(return_to_address)
  end
  
end
