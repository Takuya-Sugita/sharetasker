# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # PUT /resource
  def update

    if params[:name]
      @user.name = params[:name]
      @user.image_name = params[:image_name]
      puts params
      if @user.save
        flash[:notice] = "変更を保存しました"
        redirect_to profile_path(@user)
      else
        flash[:notice] = "変更の保存に失敗しました"
        redirect_to profile_path(@user)
      end
    else
      super
    end

  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    "/users/#{current_user.id}"
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    "/login"
  end
end
