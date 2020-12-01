require 'byebug'

class UsersController < ApplicationController

  before_action :authenticate_user ,{only: [:index, :show, :edit, :update, :destroy]}
  before_action :forbid_login_user,{only:[:create, :login_form, :login]}
  before_action :ensure_correct_user ,{only: [:edit, :update, :destroy]}
  before_action :allowed_params, {only: [:create_book]}
  before_action :check_basic, {only: [:upgrade]}

  skip_before_action :verify_authenticity_token
  #private :show_error (error_message, return_to_address)


  def index
    @users = User.all
  end

  

  def success
    ActiveMerchant::Billing::Base.mode = :test

    gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
                :login => 'TestMerchant',
                :password => 'password')

    # ActiveMerchant accepts all amounts as Integer values in cents
    amount = 1000  # $10.00

    # The card verification value is also known as CVV2, CVC2, or CID
    credit_card = ActiveMerchant::Billing::CreditCard.new(
                    :first_name         => 'Bob',
                    :last_name          => 'Bobsen',
                    :number             => '4242424242424242',
                    :month              => '8',
                    :year               => Time.now.year+1,
                    :verification_value => '000')

    # Validating the card automatically detects the card type
    if credit_card.validate.empty?
      # Capture $10 from the credit card
      response = gateway.purchase(amount, credit_card)
      
      if response.success?
        @message= "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
      else
        raise  StandardError, @message= response.message
      end
    end

  end

  def upgrade
    @plans = {"ask a cooking course" => "You could learn the way to cook from our skilled chef directly ;)",
      "download a pdf of recipes" => "You don't need to browse the site everytime, you could buy a recipe by one click easily!"}
  end

  def thanks
    @user = @current_user
    UserMailer.with(user: @user).upgrade_email.deliver_now
    if @current_user.role == "basic"
      @current_user.role = "premium"
      @current_user.save
    end
  end

  def recipe_book
    @request = Request.new
    @meals= Meal.where(book: true)
  end

  @@bid=0
  @@pdf_file_paths=[]

  def create_book
    #byebug
    arr= allowed_params[:pdfs]
    @book = Book.new(title: allowed_params[:title])
    @book.save
    @@bid= @book.id
    #pdf_file_names  = []#["pasta.pdf","pizza.pdf"]
    pdf_meals = [] #array of meals (object)

    arr.count.times{ |i|
      #@book.meals.create(id: arr[i])
      @meal= Meal.find(arr[i])
      pdf_meals << @meal
      @book.meals << @meal      
      @book.save
    }
    
    @@pdf_file_paths  = pdf_meals.map! do |meal|
      meal_type= MealType.find(meal.meal_type)
      Rails.root.join("app/pdfs/#{meal_type.description}/#{meal.title}.pdf")
    end
    if !@@pdf_file_paths.nil?
      flash[:notice]= "New book request created successfully, please go to payment for confirmation!"
      redirect_to confirm_book_users_url
    else
      flash[:notice]= "Insertion contains error..try again!"
      render("users/recipe_book")
    end
  end

  def confirm_book
    @book= Book.find(@@bid)
  end

  def payment_book
    @book= Book.find(@@bid)
    @pdfForms = CombinePDF.new
    @@pdf_file_paths.each do |path|
      @pdfForms << CombinePDF.load(path) #path is relative path to pdf file stored locally like path/to/801.pdf
    end
    @pdfForms.number_pages # numbering is ok to have here, later send it directly to the user so..
    @pdfForms.save "app/pdfs/user_book/#{@book.title}.pdf"
    @user = @current_user
    UserMailer.with(user: @user, book: @book).book_email.deliver_now
    if !@pdfForms.nil?
      flash[:notice]= "New book created successfully!"
      redirect_to success_users_url
    else
      flash[:notice]= "Inserted account doesn't exist..try again!"
      render("users/recipe_book")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    # NOT HERE!!!!! @user = User.new(name: params[:name], email: params[:email])
    @user = User.new
  end



  def create_postman
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create
    
   @user = User.new # Needed for printing error messages
   
   #respond_to do |format|
    #if params[:user_name].present? && params[:email].present? && params[:user_password].present?
      #@user = User.new(name: params[:user_name], email: params[:email], password: params[:user_password])
      @user.assign_attributes(name: params[:user_name], email: params[:email], password: params[:user_password])
      if /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/.match(params[:email])
        if /^[a-zA-Z0-9_.+-]{4,8}$/.match(params[:user_password])
          byebug
          if @user.save
            #TaskMailer.creation_email(@user).deliver_now
            
            #UserMailer.with(user: @user).welcome_email.deliver_now
 
            session[:user_id]=@user.id
            flash[:notice]= "Thank you for the registration!"
            redirect_to("/users/#{@user.id}")
          else
            show_error("Something went wrong..try again!","users/new")
          end
        else
          show_error("Inserted password is not valid..try again!","users/new")
        end
      else
        show_error("Inserted email is not valid..try again!","users/new")
      end
    #else
     # show_error("Reading the insertions went wrong..try again!!!!","users/new")
    #end
   #end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if params[:user_name].present? && params[:email].present? && params[:password].present?
      @user.name = params[:user_name]
      @user.email = params[:email]
      @user.password = params[:password]
      if /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/.match(params[:email])
        if /^[a-zA-Z0-9_.+-]{4,8}$/.match(params[:password])
          if @user.save
            flash[:notice]= "Updated successfully!"
            redirect_to("/users/#{@user.id}")
          else
            show_error("Something went wrong..try again!","users/#{@user.id}/edit")
          end
        else
          show_error("Inserted password is not valid..try again!","users/#{@user.id}/edit")
        end
      else
        show_error("Inserted email is not valid..try again!","users/#{@user.id}/edit")
      end
    else
      show_error("Reading the insertions went wrong..try again!!!!","users/#{@user.id}/edit")
    end
  end

  def login_form

  end

  def login
    #@user = User.find_by(email: params[:email],password_digest: params[:password])
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:notice]= "Loggined successfully!"
        redirect_to("/meals")
      else
        flash[:notice]= "Something went wrong..try again!"
        render("users/login_form")
      end
    else
      flash[:notice]= "Inserted account doesn't exist..try again!"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice]= "Logouted successfully!"
    redirect_to("/login")
  end

  def ensure_correct_user
    if  @current_user.id != params[:id].to_i
      flash[:notice]= "You don't have a right to modify this page"
      redirect_to("/meals")
    end
  end

  def destroy
    #@comments = @current_user.comments
    #@comments.destroy
    #sql = "DELETE from comments
    #       WHERE commenter = #{@current_user.id}"
    #ActiveRecord::Base.connection.execute(sql)
    #@comments= Comment.where(commenter: @current_user)
    all_meals= @current_user.meals
    all_meals.each do |meal|
      if meal.image.present?
        #File.delete(Rails.root + "public/meal_images/#{meal.image}")
        meal.remove_image!
        meal.save!
      end
    end
    @current_user.destroy
    #@comments= Comment.where(commenter: @current_user)
    # @comments.destroy

    flash[:notice]= "Deleted successfully!"
    #flash[:notice]= "#{@comments}!"
    redirect_to("/users/new")
  end

  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end

  def allowed_params
    params.require(:request)
  end

  def check_basic
    unless @current_user.role == "basic"
      redirect_to("/meals")
    end
  end

end
