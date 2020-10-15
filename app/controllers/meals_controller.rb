class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  # show action -> to show recipe depends on each meal
  def show
    @id = params[:id]
  end
end
