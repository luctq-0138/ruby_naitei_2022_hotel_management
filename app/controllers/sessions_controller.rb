class SessionsController < ApplicationController
  before_action :not_logged_in, only: %i(create new)
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      handle_login user
    else
      flash.now[:error] = t ".login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_url
  end

  private
  def check_logged_in
    return unless logged_in?

    redirect_to root_path
  end

  def not_logged_in
    return unless logged_in?

    if current_user.user?
      redirect_to root_url
    else
      redirect_to admin_root_url
    end
  end
end
