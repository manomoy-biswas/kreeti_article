# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :edit, :like, :new]
  before_action :set_article, only: [:edit, :destroy, :like, :show, :update]
  # respond_to :js, :json, :html

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path, flash: {success: 'Article published' }
    else
      render 'new', flash: {danger: 'something went wrong'}
    end
  end

  def destroy
    return unless current_user.admin || @article.user_id == current_user.id

    if @article.destroy
      redirect_to articles_path, flash: { danger: 'Article removed'}
    else
      redirect_to request.referrer
    end
  end

  def edit; end

  def index
    @articles = Article.find_article(current_user)
  end

  def like
    if !current_user.liked? @article
      @article.liked_by current_user
    elsif current_user.liked? @article
      @article.unliked_by current_user
    end
  end

  def new
    @article = Article.new
  end

  def print_pdf
    @article = Article.find(params[:article_id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ArticleDetails.new(@article)
        send_data(pdf.render, filename: "#{@article.article_name}.pdf", type: 'application/pdf', disposition:'inline')
      end
    end
  end

  def search
    @articles = Article.where('article_name like ?', "%#{params[:query]}%")
  end

  def show
    @comment = Comment.new
    @comment.article_id = @article.id
    @comments = @article.comments.reverse
  end

  def update
    return unless current_user.admin || @article.user_id == current_user.id

    if @article.update(article_params)
      redirect_to articles_path, flash:{success: 'updated'}
    else
      render 'edit'
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
