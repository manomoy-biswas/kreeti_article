class CommentsController < ApplicationController
  before_action :authenticate_user! , only: [:create, :destroy, :edit, :comment_like, :update]
  before_action :set_comment, only: [:destroy, :edit, :comment_like, :update]
  # respond_to :js, :json, :html

  def create
    @comment = Comment.new(comments_params)
    @comment.user_id = current_user.id
    @comment.article_id = params[:article_id]
    redirect_to request.referrer if @comment.save
  end

  def destroy
    return unless current_user.admin || @comment.user_id == current_user.id

    redirect_to request.referrer if @comment.destroy
  end

  def edit; end

  def index; end

  def comment_like
    if !current_user.liked? @comment
      @comment.liked_by current_user
    elsif current_user.liked? @comment
      @comment.unliked_by current_user
    end
  end

  def update
    return unless current_user.admin || @comment.user_id == current_user.id

    redirect to request.referrer if @comment.update(comments_params)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comments_params
    params.require(:comment).permit(:comment_title, :comment)
  end
end
