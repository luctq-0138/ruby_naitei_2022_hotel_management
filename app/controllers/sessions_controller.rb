class SessionsController < ApplicationController
  layout "layouts/application_login_signup", only: %i(create new)

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      handle_login user
    else
      flash.now[:danger] = t ".login_fail"
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
end
