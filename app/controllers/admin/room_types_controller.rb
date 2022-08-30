class Admin::RoomTypesController < Admin::BaseController
  before_action :find_room_type, only: %i(edit update destroy)
  def index
    @search = RoomType.ransack params[:q]
    @pagy, @room_types = pagy @search.result.newest, page: params[:page],
                                            items: Settings.page.admin_rooms_tb_size
    @room_types_export = @search.result.includes(:rooms)
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def new
    @room_type = RoomType.new
  end

  def update
    if @room_type.update room_type_params.except("rooms")
      flash[:success] = t ".update_success"
      redirect_to admin_room_types_path
    else
      flash[:danger] = t ".update_fail"
      render :edit
    end
  end

  def destroy
    if @room_type.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to admin_room_types_path
  end

  def create
    @room_type = RoomType.new room_type_params.except("rooms")
    if @room_type.save
      flash[:success] = t ".create_success"
      redirect_to admin_room_types_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit
    return if @room_type

    flash[:danger] = t ".find_fail"
    redirect_to admin_room_types_path
  end

  private
  def find_room_type
    @room_type = RoomType.find_by id: params[:id]
    return if @room_type

    flash[:danger] = t ".find_fail"
    redirect_to admin_room_types_path
  end

  def room_type_params
    params.require(:room_type).permit %i(name cost image capacity size services description rooms)
  end
end
