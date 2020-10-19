class MealsController < ApplicationController


  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}

  def index
    @meals = Meal.all.order(created_at: :desc)
  end

  # show action -> to show recipe depends on each meal
  def show
    #@id = params[:id]
    @meal = Meal.find_by(id: params[:id])
    @user = @meal.user
    @mealType = MealType.find_by(id: @meal.meal_type)
  end

  def new
    @meal = Meal.new
    @mealTypes = MealType.all
  end

  def create
    @mealTypes = MealType.all
    @mealType = MealType.find_by(description: params[:meal_type])
    @meal = Meal.new
    if @mealType
      #@meal = Meal.new(name: params[:meal_name],user_id: @current_user.id, content: params[:content], meal_type: @mealType.id)
      @meal = Meal.new(title: params[:title],user_id: @current_user.id, content: params[:content], meal_type: @mealType.id)
      #@mealTypes = MealType.all
      if @meal
        if @meal.save
          flash[:notice]= "Created new recipe successfully!"
          redirect_to("/meals/index")
        else
          flash[:notice]= "Save function went wrong..try again!"
          render("meals/new")
        end
      else
        flash[:notice]= "Reading the insertions went wrong..try again!"
        render("meals/new")
      end
    else
      flash[:notice]= "No type has been selected..try again!"
      render("meals/new")
    end
  end

  def edit
    @meal = Meal.find_by(id: params[:id])
    @mealTypes = MealType.all
  end

  def update
    @mealTypes = MealType.all
    @meal = Meal.find_by(id: params[:id])
    if @meal
      @mealType = MealType.find_by(description: params[:meal_type])
      @meal.title = params[:title]
      @meal.content = params[:content]
      if @mealType
        @meal.meal_type = @mealType.id
        if @meal.save
          flash[:notice]= "Modified successfully!"
          redirect_to("/meals/index")
        else
          flash[:notice]= "Save function went wrong..try again!"
          render("meals/edit")
        end
      else
        flash[:notice]= "No type has been selected..try again!"
        render("meals/edit")
      end
    else
      flash[:notice]= "Inserted id doesn't exist..try again!"
      render("meals/edit")
    end
  end



  def destroy
    @meal = Meal.find_by(id: params[:id])
    flash[:notice]= "Deleted successfully!"
    @meal.destroy
    redirect_to("/meals/index")
  end

  def ensure_correct_user
    @meal= Meal.find_by(id: params[:id])
    if @meal.user_id != @current_user.id
      flash[:notice]= "You don't have a right to modify this page"
      redirect_to("/meals/index")
    end
  end

end
