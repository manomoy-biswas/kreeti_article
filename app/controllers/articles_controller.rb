class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update]
  def index
    @articles = Article.find_article(current_user)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path, flash: {success: "Article published" }
    else
      render "new", flash: {danger: "something went wrong"}
    end
  end
  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, flash:{success: "updated"}
    else
      render "edit"
    end
  end


  private

  def article_params
    params.require(:article).permit(:article_name, :description, :image)
  end

  def set_user
    @article = Article.find(params[:id])
  end
end
