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
end
