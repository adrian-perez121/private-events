class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def require_user
    if current_user.id == params[:user_id].to_i
    else
      flash.notice = "You cannot create an event for someone else"
      redirect_to root_path
    end
  end
end
