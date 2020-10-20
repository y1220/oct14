require 'byebug'

class UsersController < ApplicationController

  before_action :authenticate_user ,{only: [:index, :show, :edit, :update, :destroy]}
  before_action :forbid_login_user,{only:[:create, :login_form, :login]}
  before_action :ensure_correct_user ,{only: [:edit, :update, :destroy]}

  #private :show_error (error_message, return_to_address)


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
    @user = User.new # Needed for printing error messages
    if params[:user_name].present? && params[:email].present? && params[:user_password].present?
      @user = User.new(name: params[:user_name], email: params[:email], password: params[:user_password])
      if /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/.match(params[:email])
        if /^[a-zA-Z0-9_.+-]{4,8}$/.match(params[:user_password])
          if @user.save
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
    else
      show_error("Reading the insertions went wrong..try again!!!!","users/new")
    end
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
            flash[:notice]= "Something went wrong..try again!"
            render("users/#{@user.id}/edit")
          end
        else
          flash[:notice]= "Inserted password is not valid..try again!"
          render("users/#{@user.id}/edit")
        end
      else
        flash[:notice]= "Inserted email is not valid..try again!"
        render("users/#{@user.id}/edit")
      end
    else
      flash[:notice]= "Reading the insertions went wrong..try again!!!!"
      render("users/#{@user.id}/edit")
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
        redirect_to("/meals/index")
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
      redirect_to("/meals/index")
    end
  end

  def destroy
    @current_user.destroy
    flash[:notice]= "Deleted successfully!"
    redirect_to("/users/new")
  end

  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end

end
