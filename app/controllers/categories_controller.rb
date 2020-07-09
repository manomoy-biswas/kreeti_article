class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, flash: {success: "category added"}
    else
      render "new"
    end
  end

  def edit
  end

  def destroy
    return unless current_user.admin
    return redirect_to request.referrer, flash: {success: "category deleted"} if @category.destroy
    flash[:warning] = "Cant be deleted"
  end

  def update
    return unless current_user.admin
    if @category.update(category_params)
      redirect_to categories_path, flash: { success: "updated"}
    else
      render "edit"
    end
  end
  private
  def category_params
    params.require(:category).permit(:category_name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
