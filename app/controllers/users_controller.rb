class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update]
  
  def index
    @users = User.all
  end

  def new
    @user = user.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, flash: { success: "Signup success" }
    else
      render "new", flash: { danger: "Something went wrong" }
    end
  end

  def edit
  end

  def show
  end
  private
  def user_params
    params.require(:users).permit(:name, :email, :mobile, :password, :confirm_password, :avater)
  end

  def set_user
    @user = user.find(params[:id])
end
