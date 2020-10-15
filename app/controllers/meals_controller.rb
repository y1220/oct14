class MealsController < ApplicationController
  def index
    @meals = Meal.all.order(created_at: :desc)
  end

  # show action -> to show recipe depends on each meal
  def show
    #@id = params[:id]
    @meal = Meal.find_by(id: params[:id])
  end

  def new

  end

  def create
    @meal = Meal.new(name: params[:meal_name])
    @meal.save

    redirect_to("/meals/index")
  end

  def edit
    @meal = Meal.find_by(id: params[:id])
  end

  def update
    @meal = Meal.find_by(id: params[:id])
    @meal.name = params[:meal_name]
    @meal.save
    redirect_to("/meals/index")
  end

end
