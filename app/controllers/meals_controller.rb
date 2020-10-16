class MealsController < ApplicationController


  before_action :authenticate_user

  def index
    @meals = Meal.all.order(created_at: :desc)
  end

  # show action -> to show recipe depends on each meal
  def show
    #@id = params[:id]
    @meal = Meal.find_by(id: params[:id])
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(name: params[:meal_name])
    if @meal.save
      redirect_to("/meals/index")
    else
      render("meals/new")
    end
  end

  def edit
    @meal = Meal.find_by(id: params[:id])
  end

  def update
    @meal = Meal.find_by(id: params[:id])
    @meal.name = params[:meal_name]
    if @meal.save
      redirect_to("/meals/index")
    else
      render("meals/edit")
    end
  end

  def destroy
    @meal = Meal.find_by(id: params[:id])
    @meal.destroy
    redirect_to("/meals/index")
  end

end
