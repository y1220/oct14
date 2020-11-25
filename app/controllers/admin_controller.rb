class AdminController < ApplicationController

    #before_action :ensure_correct_user
    before_action :authenticate_user 
    before_action :check_admin
    
  
  
    def index
      @participants = Participant.all.order(created_at: :desc)
    end
  
    
    def check_admin
        unless @current_user.role == "admin"
          redirect_to("/users/upgrade")
        end
    end

    def set_current_user
        @current_user= User.find_by(id: session[:user_id])
    end

    private  ## has to be the bottom of the page not to let other method as private one
    def show_error (error_message, return_to_address)
      flash[:notice]= error_message
      render(return_to_address)
    end

    
end
