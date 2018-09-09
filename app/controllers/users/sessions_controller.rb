# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  # def create
  #   @user = User.find_by(email: params[:email])
  #   if @user && @user.authenticate(params[:password])
  #     session[:user_id] = @user.id
  #     flash[:notice] = "ログインしました"
  #     redirect_to("/posts/index")
  #   else
  #     @error_message = "メールアドレスまたはパスワードが間違っています"
  #     @email = params[:email]
  #     @password = params[:password]
  #     render("users/login_form")
  #   end
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   session[:user_id] = nil
  #   flash[:notice] = "ログアウトしました"
  #   redirect_to("/login")
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
