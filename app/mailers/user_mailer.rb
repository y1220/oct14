class UserMailer < ApplicationMailer
  default from: 'happy_recipe@rails.com'
 
  def welcome_email
    @user = params[:user]
    @url= 'http://localhost:3000/login'
    mail(to: @user.email, subject: 'Welcome Happy Recipe Site')
  end

end
