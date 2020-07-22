# frozen_string_literal: true

class LikesController < ApplicationController

  def like
    @like = Like.new
    @like.user_id = current_user.id
    @like.article_id = @article.id
    if @like.save
      redirect_to request.referrer
    else
      redirect_to request.referrer, flash: {danger: 'Something error occur'}
    end
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

end
