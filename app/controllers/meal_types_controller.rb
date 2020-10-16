class MealTypesController < ApplicationController
  def assignment
  end

  def new
    @mealType = MealType.new
  end

  def create
    @mealType  = MealType.new(description: params[:description])
    @mealType.save
  end
end
