class ApiController < ApplicationController
  def status
    #render json: { status: true }
    render json: { meals_counter: Meal.all }
  end



  def create_user
    #render json: { status: true }
    render json: { meals_counter: Meal.count }
  end

end
