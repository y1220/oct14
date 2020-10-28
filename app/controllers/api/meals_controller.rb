module Api
  class MealsController < ApplicationController


    # require 'json' => true
    protect_from_forgery


    def index
      @meals = Meal.all.order(created_at: :desc)
      render json: @meals
    end

    def show
      #@id = params[:id]
      @meal = Meal.find_by(id: params[:id])
      #  @user = @meal.user
      #   @mealType = MealType.find_by(id: @meal.meal_type)
      render json: @meal

    end

    def create
      @meal = Meal.new(allowed_params)
      if @meal.save
        render json: { status: 'success', data: @meal }
      else
        render json: { status: 'error', data: @meal.errors }
      end
    end

    # return only the selected values
    def show_name
      @meal = Meal.find_by(id: params[:id])
      render json: { name: @meal.title }
    end

    def show_name_of_user_and_meal
      @meal = Meal.find_by(id: params[:id])

      render json: { meal: @meal.title, user: @meal.user.name }
    end


    def show_name_serialize
      @meal = Meal.find_by(id: params[:id])
      render json: @meal.serializable_hash(only: :title)
    end


    #private

    def allowed_params
      params.require(:meal).
        permit(:title, :content, :meal_type, :user_id)
    end

  end
end
