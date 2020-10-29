module Api
  class MealsController < ApplicationController


    # require 'json' => true
    #allow the post from the outside
    protect_from_forgery


    #def index
    #@meals = Meal.all.order(created_at: :desc)
    #render json: @meals
    #end

    def index
      meals = Meal.all
      render 'index' , locals: { meals: meals }#, formats: 'json', handlers: 'jbuilder'

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

    def show_comments_serialize
      @meal = Meal.find_by(id: params[:id])
      render json: @meal.serializable_hash(only: :title)
    end

    def except_c_u
      @meal = Meal.find_by(id: params[:id])
      #@meal = Meal.all
      render json: @meal.serializable_hash(except: [:created_at,:updated_at])
    end


    def do_capitalized_title
      @meal = Meal.find_by(id: params[:id])
      render json: @meal.serializable_hash(methods: :capitalized_title)
      #render plain: "OK!"
      # render  xml: @meal.serializable_hash(methods: :capitalized_title)

    end

    def with_comments
      @meal = Meal.find_by(id: params[:id])
      #@comments = @meal.comments
      #render json: @comments
      render json: @meal.serializable_hash(methods: :show_comments)
    end


    #added method






    # def except_c_u_all
    #@meal = Meal.find_by(id: params[:id])
    #@meals = Meal.all.map{|meal|
    #meal.serializable_hash(except: [:created_at,:updated_at])
    #}
    #render json: @meals
    #}
    #end

    private

    def allowed_params
      params.require(:meal).
        permit(:title, :content, :meal_type, :user_id)
    end



  end
end
