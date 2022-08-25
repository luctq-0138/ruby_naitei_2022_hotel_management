class AccountActivationsController < ApplicationController
  before_action :find_user, only: :edit

  def edit
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      handle_active_account @user
    else
      flash.now[:error] = t ".user_unsuccess"
      redirect_to signup_path
    end
  end

  private

  def find_user
    @user = User.find_by(email: params[:email])
    return if @user

    flash.now[:error] = t ".active_account_fail"
    redirect_to root_path
  end

  def handle_active_account user
    user.activate
    log_in user
    flash.now[:success] = t ".user_success"
    redirect_to root_path
  end
end
