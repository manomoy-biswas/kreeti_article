# frozen_string_literal: true

class ArticlesController < ApplicationController
  layout "dashboard", only: [:edit, :index, :new]
  before_action :authenticate_user!, only: [:create, :destroy, :edit, :like, :new, :update]
  before_action :set_article, only: [:edit, :destroy, :like, :show, :update]

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

  def edit 
    return unless current_user && (current_user.admin || @article.user_id == current_user.id)
  end

  def filtered_article
    @categories = Category.all
    @articles = 
    @articles = Article.filtered_by_like(params[:id], params[:filters], current_user.id)
  end

  def index
    @articles = if current_user && current_user.admin
      Article.all.includes(:category, :comments, :user )
    else
      @articles = Article.find_article(current_user)
    end
  end

  def like
    if !current_user.liked? @article
      @article.liked_by current_user
      Like.new(article_id: @article.id, user_id: current_user.id).save
    elsif current_user.liked? @article
      @article.unliked_by current_user
      Like.where(article_id: @article.id, user_id: current_user.id).destroy_all
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
    @articles = Article.search(params[:query]).order("updated_at DESC")
  end

  def show
    
    @comment = Comment.new
    @comment.article_id = @article.id
    @comments = @article.comments.order("id DESC")
    render layout: "dashboard" if current_user && (current_user.admin || @article.user_id == current_user.id)
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
