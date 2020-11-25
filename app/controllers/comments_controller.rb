class CommentsController < ApplicationController

  before_action :authenticate_user
  #before_action :ensure_correct_user,{only: [:edit, :update, :destroy]}

  def new
    @meal = Meal.find_by(id: params[:id])
    @comment= Comment.new


  end

  def create
    @meal = Meal.find_by(id: params[:id])
    #@comment= @current_user.comments.create(message: params[:message],meal_id: @meal.id, commenter: @current_user)
    @comment= @meal.comments.create(message: params[:message], commenter: @current_user.id)
    if @comment.save
      flash[:notice]= "Comment has been registered!"
      redirect_to("/meals/#{@meal.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("meals/#{@meal.id}")
      #render("meals/#{params[:id]}")
    end
  end

  def reply
    @comment=Comment.find_by(id: params[:id])
    @to_reply= Comment.find_by(id: params[:id])
    @meal=Meal.find_by(id: @comment.meal_id)
    @user = @meal.user
    @mealType = MealType.find_by(id: @meal.meal_type)
    #@reply = @comment.comments.create(message: params[:message],user_id: @current_user.id)
    @cid= params[:id]
  end

  def create_r
    @cid= params[:id]
    @to_reply= Comment.find_by(id: @cid)
    @meal=Meal.find_by(id: @to_reply.meal.id)
    @user = @meal.user
    #@comment= @current_user.comments.create(message: params[:message],meal_id: @meal.id,comment_id: @cid)
    @comment= @meal.comments.create(message: params[:message], commenter: @current_user.id, comment_id: @cid)
    #@comment = Comment.new(message: params[:message],user_id: @current_user.id,comment_id: @cid,meal_id: @meal.id)
    @comment.save
    @mealType = MealType.find_by(id: @meal.meal_type)
    if @comment.save
      flash[:notice]= "Comment has been registered!"
      #flash[:notice]= "Thank you for your comment!"
      redirect_to("/meals/#{@meal.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("meals/#{@meal.id}/comments/new")
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment
      if params[:message].present?
        @comment.message = params[:message]
        if @comment.save
          flash[:notice]= "Modified successfully!"
          redirect_to("/meals")
        else
          show_error("Save function went wrong..try again!","comments/#{@comment.id}/edit")
        end
      else
        show_error("Please fill the message..try again!!!!","comments/#{@comment.id}/edit")
      end
    else
      show_error("Inserted id doesn't exist..try again!","comments/#{@comment.id}/edit")
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    flash[:notice]= "Deleted successfully!"
    @comment.destroy
    redirect_to("/meals")
  end



  private  ## has to be the bottom of the page not to let other method as private one
  def show_error (error_message, return_to_address)
    flash[:notice]= error_message
    render(return_to_address)
  end


end
