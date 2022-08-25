class Admin::UsersController < Admin::BaseController
  def index
    @pagy, @users = pagy User.search_name(params[:name]).user.newest, page: params[:page],
                items: Settings.page.admin_user_tb_size
  end
end
