class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    # NOT HERE!!!!! @user = User.new(name: params[:name], email: params[:email])
  end

  def create
    @user = User.new(name: params[:user_name], email: params[:email])
    @user.save

    redirect_to("/users/#{@user.id}")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:user_name]
    @user.email = params[:email]
    @user.save

    redirect_to("/users/#{@user.id}")
  end

  def login_form

  end

  def login
    @user = User.find_by(email: params[:email],password: params[:password])
    if @user

      redirect_to("/meals/index")

    else

      render("users/login_form")

    end
  end
end
