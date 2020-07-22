class HomeController < ApplicationController
  def index
    @articles = Article.includes(:user, :category).all
    @categories = Category.all
  end
end
