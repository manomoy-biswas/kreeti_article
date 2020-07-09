class SessionsController < ApplicationController

  
  
  private

  def sessions_params
    params.require(:login).permit(:email, :password)

end
