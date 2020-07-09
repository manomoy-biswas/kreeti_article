class HomeController < ApplicationController
  def index
    @posts = Article.filter_by(params[:filetr])
  end
end
