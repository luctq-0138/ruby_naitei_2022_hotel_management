class Admin::UsersController < Admin::BaseController
  def index
    @pagy, @users = pagy User.search(params).user.newest, page: params[:page],
                    items: Settings.page.admin_user_tb_size
  end
end
