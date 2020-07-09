class CommentsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :update, :edit, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comments_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to request.referrer
    end
  end

  def edit
  end

  def index
  end

  def update
    return unless current_user.admin || @comment.user_id == current_user.id
    if @comment.update(comments_params)
      redirect to request.referrer
    end
  end

  def destroy
    return unless current_user.admin || @comment.user_id == current_user.id
    if @comment.destroy
      redirect_to request.referrer
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comments_params
    params.require(:comment).permit(:comment_title, :comment)
  end
end
