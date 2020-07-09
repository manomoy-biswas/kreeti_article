class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_article, only: [:edit, :show, :update, :destroy]
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
    @comment= Comment.new
    @comments = Comment.where(article_id: @article_id)
  end

  def print_pdf    
    @article = Article.find(params[:article_id])
    respond_to do |format|
      format.html 
      format.pdf do
        pdf = ArticleDetails.new(@article)
        send_data(pdf.render, filename: "#{@article.article_name}.pdf", type: "application/pdf", disposition:"inline")
      end
    end
  end

  def edit
  end

  def search
    @articles = Article.where("article_name like ?", "%#{params[:query]}%")
  end

  def update
    return unless current_user.admin || @article.user_id == current_user.id

    if @article.update(article_params)
      redirect_to articles_path, flash:{success: "updated"}
    else
      render "edit"
    end
  end

  def destroy
    return unless current_user.admin || @article.user_id == current_user.id
    if @article.destroy 
      redirect_to articles_path, flash: { danger: "Article removed"}
    else
      redirect_to request.referrer
    end
  end

  private

  def article_params
    params.require(:article).permit(:category_id, :article_name, :description, :image)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
