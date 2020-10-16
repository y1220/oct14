class UsersController < ApplicationController

  before_action :authenticate_user ,{only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user,{only:[:create, :login_form, :login]}

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
      redirect_to("/users/#{@user.id}")
    else
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
    if @user.save
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form

  end

  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user
      session[:user_id] = @user.id
      redirect_to("/meals/index")
    else
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end

end
