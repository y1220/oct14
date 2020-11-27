class UserMailer < ApplicationMailer
  #@tomato= User.find_by(id: 1)
  #default to: -> (@tomato.email),
  #default from: 'happy_recipe@rails.com'
 
  def welcome_email
    #attachment= Rails.root.join("pdfs/recipe_book/pizza_apple.pdf")
    @user = params[:user]
    @url= 'http://localhost:3000/login'
    attachments.inline['cook.png'] = File.read(Rails.public_path.join('cook.png'))
    attachments.inline['smile.png'] = File.read(Rails.public_path.join('smile.png'))
    #attachments['pizza_apple.pdf'] =  open(attachment).read
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    #mail(to: email_with_name, bcc: ENV["BCC"], subject: 'Welcome Happy Recipe Site')
    mail(to: email_with_name,  subject: 'Welcome Happy Recipe Site')
  end

  def upgrade_email
    bookname ="welcome"
    #attachment= Rails.root.join("pdfs/recipe_book/#{bookname}.pdf")
    attachment= Rails.root.join("#{bookname}.pdf")
    @user = params[:user]
    attachments.inline['upgrade.png'] = File.read(Rails.public_path.join('upgrade.png'))
    attachments.inline['smile.png'] = File.read(Rails.public_path.join('smile.png'))
    attachments["#{bookname}.pdf"] =  open(attachment).read
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    #mail(to: email_with_name, bcc: ENV["BCC"], subject: 'Thanks for upgrading')
    mail(to: email_with_name,  subject: 'Thanks for upgrading')
  end

  def book_email
    @user = params[:user]
    @book = params[:book]
    bookname ="app/pdfs/user_book/#{@book.title}"
    attachment= Rails.root.join("#{bookname}.pdf")
    #attachments.inline['upgrade.png'] = File.read(Rails.public_path.join('upgrade.png'))
    attachments.inline['smile.png'] = File.read(Rails.public_path.join('smile.png'))
    attachments["#{@book.title}.pdf"] =  open(attachment).read
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    #mail(to: email_with_name, bcc: ENV["BCC"], subject: 'Thanks for upgrading')
    mail(to: email_with_name,  subject: 'Here you are! Your book is ready :)')
  end

 

end
