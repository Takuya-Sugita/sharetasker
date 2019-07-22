class ApplicationController < ActionController::Base
  before_action :set_current_user

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email])
  # end

  def set_current_user
    current_user = User.find_by(id: session[:user_id])
  end

  #
  # def authenticate_user
  #   if @current_user == nil
  #     flash[:notice] = "ログインが必要です"
  #     redirect_to("/login")
  #   end
  # end
  #
  def forbid_login_user
    if current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/posts/index")
    end
  end




  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
