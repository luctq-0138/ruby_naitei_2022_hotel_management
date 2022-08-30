class Admin::UsersController < Admin::BaseController
  def index
    @search = User.ransack params[:q]
    @pagy, @users = pagy @search.result.user.newest, page: params[:page],
                items: Settings.page.admin_user_tb_size
  end
end
