class Admin::BaseController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user, :must_be_admin

  private

  def must_be_admin
    return if current_user.admin?

    redirect_back(fallback_location: root_path)
  end
end
