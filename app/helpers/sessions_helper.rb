module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def handle_login user
    if user.activated?
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if user.user?
        redirect_to root_url
      else
        redirect_to admin_root_url
      end
    else
      flash[:warning] = t ".account_not_activated"
      redirect_to root_url
    end
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    forget current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "users.require_login"
    redirect_to login_path
  end

  def store_search search
    session[:search] = search
  end
end
