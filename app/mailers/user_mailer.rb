class UserMailer < ApplicationMailer
  #@tomato= User.find_by(id: 1)
  #default to: -> (@tomato.email),
  #default from: 'happy_recipe@rails.com'
 
  def welcome_email
    @user = params[:user]
    @url= 'http://localhost:3000/login'
    attachments.inline['cook.png'] = File.read(Rails.public_path.join('cook.png'))
    attachments.inline['smile.png'] = File.read(Rails.public_path.join('smile.png'))
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, bcc: ENV["BCC"], subject: 'Welcome Happy Recipe Site')
  end

end
