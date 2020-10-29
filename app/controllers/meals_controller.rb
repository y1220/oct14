require 'mimemagic'
require  "byebug"
#require 'uploaders/file_uploader'
require 'carrierwave/orm/activerecord'
class MealsController < ApplicationController


  before_action :authenticate_user
  before_action :ensure_correct_user,{only: [:edit, :update,:edit_image, :update_image, :destroy]}

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
    @descriptions=@mealTypes.map{|x| x.description}

  end

  def create
    @meal = Meal.new
    @mealTypes = MealType.all
    @descriptions=@mealTypes.map{|x| x.description}


    @meal.title=allowed_params["title"]
    @meal.content=allowed_params["content"]
    @mealType = MealType.find_by(description: allowed_params["meal_type"])
    @meal.meal_type=@mealType.id
    @meal.user_id= @current_user.id
    image_from_params = params[:meal][:image]


    if @meal.save
      if image_from_params.present?
        #   @meal.image= "#{@meal.id}.jpg"
        #    @meal.save
        #     uploader = FileUploader.new
        #      uploader.store!(params[:meal][:image])
        #       @message.photo = @message.photo.filename
        #@message.save!


        #photo = open(File.join("meal",image_from_params.original_filename)) # /meal/pizza.pdf
        @meal.image = FileUploader.new
        @meal.image.store!(image_from_params)
        @meal.save!
        #image_pic= params[:meal][:image]
        #File.binwrite("public/meal_images/1.jpg",image_pic.read)
        #File.binwrite("public/meal_images/#{@meal.image}",image_pic.read)
      end
      flash[:notice]= "New meal created successfully!#{allowed_params["image"].present?}"
      redirect_to("/meals")
      #render("/meals/index")
    else
      show_error("Inserted id doesn't exist..try again!","meals/new")
    end

  end



  def edit
    @meal = Meal.find_by(id: params[:id])
    @mealTypes = MealType.all
    @descriptions=@mealTypes.map{|x| x.description}
  end

  def update
    @mealTypes = MealType.all
    @meal = Meal.find_by(id: params[:id])
    @descriptions=@mealTypes.map{|x| x.description}


    @meal.title=allowed_params["title"]
    @meal.content=allowed_params["content"]
    @mealType = MealType.find_by(description: allowed_params["meal_type"])
    @meal.meal_type=@mealType.id
    @meal.user_id= @current_user.id
    image_from_params = params[:meal][:image]
    if @meal.save
      if image_from_params.present?
        @meal.image = FileUploader.new
        @meal.image.store!(image_from_params)
        @meal.save!
      end
      flash[:notice]= "New meal created successfully!#{allowed_params["image"].present?}"
      redirect_to("/meals/index")
    else
      show_error("Inserted id doesn't exist..try again!","meals/#{params[:id]}/edit")
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
    @meal.remove_image!
    @meal.save!
    @meal.destroy
    #File.delete(Rails.root + "public/collections_image/meal/#{@meal.image}")
    flash[:notice]= "Deleted successfully!"
    redirect_to("/meals")
  end

  def ensure_correct_user
    @meal= Meal.find_by(id: params[:id])
    if @meal.user_id != @current_user.id
      flash[:notice]= "You don't have a right to modify this page"
      redirect_to("/meals")
    end
  end

  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end


  def fileupload_param
    params.require(:fileupload).permit(:file)
  end

  def allowed_params
    params.require(:meal).
      permit(:title, :content, :meal_type)
  end



end
