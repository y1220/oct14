class UserMailer < ApplicationMailer
  default from: 'happy_recipe@rails.com'
 
  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end
