class UsersController < ApplicationController
  before_action :find_user, except: %i(index new create)
  before_action :logged_in_user, :must_be_user, except: %i(create new)

  def new
    @user = User.new
  end

  def index; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:success] = t ".mail_notice"
      redirect_to root_url
    else
      flash.now[:error] = t ".create_fail"
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
          .permit(:name, :email, :phone_number, :address, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash.now[:error] = t ".find_fail"
    redirect_to root_path
  end
end
