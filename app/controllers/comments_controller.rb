class CommentsController < ApplicationController
  def new
    @meal = Meal.find_by(id: params[:id])
    @comment= Comment.new


  end

  def create
    @meal = Meal.find_by(id: params[:id])
    #@comment= @current_user.comments.create(message: params[:message],meal_id: @meal.id, commenter: @current_user)
    @comment= @meal.comments.create(message: params[:message], commenter: @current_user)
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
    @comment= @meal.comments.create(message: params[:message], commenter: @current_user, comment_id: @cid)
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

end
