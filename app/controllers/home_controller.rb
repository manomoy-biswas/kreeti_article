class HomeController < ApplicationController
  def index
    # if params[:filters] == "" || !params[:filters]
    #   @articles = Article.includes(:user, :category).all
    #   @articles = Article.find_article(current_user)
    # elsif
    #   @articles = Article.joins("INNER JOIN likes ON articles.id = likes.article_id").where(likes: {user_id: current_user.id})
    # end
    @articles = Article.filtered_by_like(nil, params[:filters], current_user)

    @categories = Category.all
  end
  def overview
    render layout: "dashboard"
  end

end
