class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)

  def new
    @user = User.new
  end

  def index; end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t ".create_success"
      redirect_to login_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update; end

  def show; end

  def destroy; end

  private
  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".find_fail"
    redirect_to root_path
  end
end
