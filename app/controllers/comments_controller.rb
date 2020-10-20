class CommentsController < ApplicationController
  def new
    @comment= Comment.new
    @meal = Meal.find_by(id: params[:id])

  end

  def create
    @meal = Meal.find_by(id: params[:id])
    @comment= @meal.comments.create(message: params[:message])
    @comment.save

    if @comment.save
      flash[:notice]= "Thank you for your comment!"
      redirect_to("/meals/#{@meal.id}")
    else
      flash[:notice]= "something went wrong..try again!"
      render("/meals/#{@meal.id}/comments/new")
    end
  end
end
