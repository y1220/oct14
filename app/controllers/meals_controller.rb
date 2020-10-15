class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  # show action -> to show recipe depends on each meal
  def show
    #@id = params[:id]
    @meal = Meal.find_by(id: params[:id])
  end

  def new

  end


end
