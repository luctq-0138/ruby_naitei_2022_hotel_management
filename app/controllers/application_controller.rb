class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  layout :determine_layout

  def determine_layout
    if user_signed_in?
      (current_user.admin? ? "application_admin" : "application")
    else
      "application"
    end
  end

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include?(locale)
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def must_be_user
    return if current_user.user?

    redirect_back(fallback_location: admin_root_path)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::USER_ATTRS
    devise_parameter_sanitizer.permit :account_update, keys: User::USER_ATTRS
  end

  def after_sign_in_path_for resource
    unless current_user.activated?
      sign_out
      flash[:warning] = t ".account_not_activated"
      stored_location_for(resource) || root_path
    end
    if current_user&.admin?
      stored_location_for(resource) || admin_root_path
    else
      stored_location_for(resource) || root_path
    end
  end
end
