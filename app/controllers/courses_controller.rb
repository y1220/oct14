class CoursesController < ApplicationController
  def index
    @courses = Course.all.order(created_at: :desc)
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
      redirect_to("/meals")
    else
      show_error("Inserted id doesn't exist..try again!","courses/new")
    end

  end

  

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def allowed_params
    params.require(:course).
      permit(:name, :description, :price)
  end
end
