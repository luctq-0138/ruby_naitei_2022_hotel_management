class Admin::BaseController < ApplicationController
  layout "layouts/application_admin"
  before_action :logged_in_user, :must_be_admin

  def must_be_admin
    return if current_user.role == 1

    redirect_back(fallback_location: root_path)
  end
end
