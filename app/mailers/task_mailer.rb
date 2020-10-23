class TaskMailer < ApplicationMailer

  #default from: 'recipe@rails.com'

  def creation_email(user)
    @user = user
    @url  = 'http://localhost:3000/login'
    mail(
      subject: 'mail registration',
      #to: 'write the email address here'
      to: @user.email
      #from: 'recipe@rails.com'  Better to use default in application_mailer
    )
  end
end
