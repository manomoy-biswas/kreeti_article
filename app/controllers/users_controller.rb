class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, flash: { success: "Signup success" }
    else
      render "new", flash: { danger: "Something went wrong" }
    end
  end

  def show
  end
  def destroy
    return unless current_user.admin
    return redirect_to users_path, flash: {success: t("user.destroy_success")} if @user.destroy
    redirect_to users_path, flash: {success: t("user.failed")}
  end

  def edit
    redirect_to root_path if !current_user.admin
  end 

  def update
    if current_user.admin
      if @user.update(user_params)
        redirect_to users_path, flash: { success: t("user.update_success") }
      else
        render "edit", flash: { danger: t("user.failed")}
      end
    end
  end  

  private
  def user_params
    params.require(:user).permit(:name, :email, :mobile, :password, :confirm_password, :avater)
  end

  def set_user
    @user = user.find(params[:id])
  end
end
