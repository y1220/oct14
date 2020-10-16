class ApplicationController < ActionController::Base

  # declare the action which is needed by all the other actions
  before_action :set_current_user

  def set_current_user
    @current_user= User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user==nil
      redirect_to("/login")
    end
  end

  def forbid_login_user
    # already loginned
    if @current_user
      redirect_to("/meals/index")
    end
  end


end
