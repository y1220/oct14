class CommentsController < ApplicationController
  def new
    @comment= Comment.new
  end

  def create
    @comment= Comment.new(message: params[:message])
    @comment.save
    @meal = Meal.find_by(id: params[:id])
  end
end
