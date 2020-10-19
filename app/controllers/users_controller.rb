class UsersController < ApplicationController

  before_action :authenticate_user ,{only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user,{only:[:create, :login_form, :login]}
  before_action :ensure_correct_user ,{only: [:edit, :update]}


  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    # NOT HERE!!!!! @user = User.new(name: params[:name], email: params[:email])
    @user = User.new
  end

  def create
    @user = User.new(name: params[:user_name], email: params[:email], password: params[:user_password])
    if @user.save
      session[:user_id]=@user.id
      flash[:notice]= "Thank you for the registration!"
      redirect_to("/users/#{@user.id}")
    else
      flash[:notice]= "Something went wrong..try again!"
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:user_name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      flash[:notice]= "Updated successfully!"
      redirect_to("/users/#{@user.id}")
    else
      flash[:notice]= "Something went wrong..try again!"
      render("users/edit")
    end
  end

  def login_form

  end

  def login
    #@user = User.find_by(email: params[:email],password_digest: params[:password])
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice]= "Loggined successfully!"
      redirect_to("/meals/index")
    else
      flash[:notice]= "Something went wrong..try again!"
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
      redirect_to("/meals/index")
    end
  end

end
