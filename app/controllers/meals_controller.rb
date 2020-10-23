class MealsController < ApplicationController


  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}
  #before_action :search, {only: [:result]}

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
    @meal = Meal.new
    @mealTypes = MealType.all
    if params[:title].present? && params[:content].present? && params[:meal_type].present?
      #unless !params[:title].present? || !params[:content].present?|| !params[:meal_type].present?
      @mealType = MealType.find_by(description: params[:meal_type])
      if @mealType
        #@meal = Meal.new(name: params[:meal_name],user_id: @current_user.id, content: params[:content], meal_type: @mealType.id)
        @meal = @current_user.meals.create(title: params[:title],user_id: @current_user.id, content: params[:content], meal_type: @mealType.id)

        #@meal = Meal.new(title: params[:title],user_id: @current_user.id, content: params[:content], meal_type: @mealType.id)
        #@mealTypes = MealType.all
        if @meal
          if @meal.save
            flash[:notice]= "Created new recipe successfully!"
            redirect_to("/meals/index")
          else
            show_error("Save function went wrong..try again!","meals/new")
          end
        else
          show_error("Reading the insertions went wrong..try again!","meals/new")
        end
      else
        show_error("No type has been selected..try again!","meals/new")
      end
    else
      show_error("Reading the insertions went wrong..try again!!!!","meals/new")
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
      if params[:title].present? && params[:content].present? && params[:meal_type].present?
        @mealType = MealType.find_by(description: params[:meal_type])
        @meal.title = params[:title]
        @meal.content = params[:content]
        if @mealType
          @meal.meal_type = @mealType.id
          if @meal.save
            flash[:notice]= "Modified successfully!"
            redirect_to("/meals/index")
          else
            show_error("Save function went wrong..try again!","meals/edit")
          end
        else
          show_error("No type has been selected..try again!","meals/edit")
        end
      else
        show_error("Reading the insertions went wrong..try again!!!!","meals/new")
      end
    else
      show_error("Inserted id doesn't exist..try again!","meals/edit")
    end
  end



  def search
    # @@s_meals ||=nil

  end

  #$ ids = ||
  def create_s
    #tmp= Meal.where(title: params[:keyword])
    #@@s_meals = tmp.clone
    #@@s_meals = Meal.where(title: params[:keyword])
    @@s_meals= Meal.where(title: params[:keyword])
    # @@s_meals="SELECT *
    #             FROM meals
    #           WHERE title LIKE '%#{params[:keyword]}%'"
    if @@s_meals
      flash[:notice]= "Searced successfully!"
      redirect_to("/meals/result")
    else
      show_error("No meal found..try again!", "meals/search")
    end

  end

  def result
    @results = []
    @results = @@s_meals.clone
    #@s_meals= Meal.all
    #@s_meals = Meal.find_by(title: params[:keyword])
    #@s_meals = Meal.where("title like ?", "%#{params[:keyword]}%")
    #@s_meals
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

  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end

end
