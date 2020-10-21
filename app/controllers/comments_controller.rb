class CommentsController < ApplicationController
  def new
    @comment= Comment.new
    @meal = Meal.find_by(id: params[:id])

  end

  def create
    @meal = Meal.find_by(id: params[:id])
    @comment= @meal.comments.create(message: params[:message],user_id: @current_user.id)
    @comment.save

    if @comment.save
      flash[:notice]= "Thank you for your comment!"
      redirect_to("/meals/#{@meal.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("/meals/#{@meal.id}/comments/new")
    end
  end

  def reply
    @comment=Comment.find_by(id: params[:id])
    @to_reply= Comment.find_by(id: params[:id])
    @meal=Meal.find_by(id: @comment.meal_id)
    @user = @meal.user
    @mealType = MealType.find_by(id: @meal.meal_type)
    @reply = @comment.comments.create(message: params[:message],user_id: @current_user.id)
    @cid= params[:id]
  end

  def create_r
    @cid= params[:id]
    @to_reply= Comment.find_by(id: @cid)
    @meal=Meal.find_by(id: @to_reply.meal_id)
    @user = @meal.user
    @comment= @meal.comments.create(message: params[:message],user_id: @current_user.id,comment_id: @cid)
    @comment.save
    @meal=Meal.find_by(id: @comment.meal_id)
    @user = @meal.user
    @mealType = MealType.find_by(id: @meal.meal_type)


    if @comment.save
      flash[:notice]= "Thank you for your comment!"
      redirect_to("/meals/#{@meal.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("/meals/#{@meal.id}/comments/new")
    end
  end

end
