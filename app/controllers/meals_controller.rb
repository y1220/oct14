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
        @meal = @current_user.meals.create(title: params[:title],user_id: @current_user.id, content: params[:content], meal_type: @mealType.id)
        if @meal
          if @meal.save
            if params[:image].present?
              @meal.image= "#{@meal.id}.jpg"
              @meal.save
              image_pic= params[:image]
              File.binwrite("public/meal_images/#{@meal.image}",image_pic.read)
            end
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
    #@@s_meals= Meal.where(title: params[:keyword])
    # @@s_meals="SELECT *
    #             FROM meals
    #           WHERE title LIKE '%#{params[:keyword]}%'"
    #@@s_meals = []
    #all_m= Meal.all

    #all_m.each do |meal|
    #if "/#{params[:keyword])}/".match(meal.title)
    #  @@s_meals<< meal
    # end
    #end

    #HASH
    #h = {}
    #h.merge!(key: "bar")
    # => {:key=>"bar"}

    #SORT
    #people.sort_by { |name, age| age }
    # => [[:joan, 18], [:fred, 23], [:pete, 54]]

    t_keywords = params[:t_keyword].split
    c_keywords = params[:c_keyword].split
    all_meals = Meal.all
    t_h = {}
    c_h = {}
    all_meals.each do |meal|
      t_count=0
      t_keywords.each do |keyword|
        if meal.title.downcase.include?(keyword.downcase)
          t_count +=1
        end
      end
      if t_count != 0
        t_h.merge!(meal.id => t_count)
      end
      c_count=0
      c_keywords.each do |keyword|
        if meal.content.downcase.include?(keyword.downcase)
          c_count +=1
        end
      end

      if c_count != 0
        c_h.merge!(meal.id => c_count)
      end
    end



    # sort by descending order
    t_order= t_h.sort_by {|id, num| -num}.map {|key,value|key}

    # id -> meal object
    @@t_meals= []
    t_order.each do |id|
      @@t_meals<< Meal.find_by(id: id)
    end

    c_order= c_h.sort_by {|id, num| -num}.map {|key,value|key}

    # id -> meal object
    @@c_meals= []
    c_order.each do |id|
      @@c_meals<< Meal.find_by(id: id)
    end


    #c_keywords = params[:c_keyword].split
    #@@t_meals = Meal.where('title LIKE ?', "%#{params[:t_keyword]}%").all
    #@@c_meals = Meal.where('content LIKE ?', "%#{params[:c_keyword]}%").all
    # if @@t_meals || @@c_meals
    if @@t_meals||@@c_meals
      flash[:notice]= "Searced successfully!"
      redirect_to("/meals/result")
    else
      show_error("No meal found..try again!", "meals/search")
    end

  end

  def result

    @d_results = []
    # intersection
    @d_results = @@t_meals & @@c_meals

    @t_results = []
    @t_results = @@t_meals.clone

    @c_results = []
    @c_results = @@c_meals.clone




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
