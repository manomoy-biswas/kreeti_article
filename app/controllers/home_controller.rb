class HomeController < ApplicationController
  def index
    @articles = Article.includes(:user, :category).all
  end
end
