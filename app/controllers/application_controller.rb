class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) << [:username, :email]
   devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :avatar) }
    
  end


  def after_sign_in_path_for(current_user)
	 user_path(current_user)
	end

	def after_sign_up_path_for(current_user)
	  user_path(current_user)
	end

  def after_update_path_for(resource)
    user_path(resource)
  end


end
