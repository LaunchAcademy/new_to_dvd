class UserStatusController < ApplicationController
  def update
    current_user.update_attributes(user_params)
    flash[:notice] = "Your mail status is now set to: #{current_user.mail_status}"
    redirect_to root_path
  end

  protected
  def user_params
    params.require(:user).permit(:mail_status)
  end
end
