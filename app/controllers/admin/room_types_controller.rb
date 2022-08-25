class Admin::RoomTypesController < Admin::BaseController
  before_action :find_room_type, only: %i(edit update destroy)
  def index
    @pagy, @room_types = pagy RoomType.all.newest, page: params[:page],
                                            items: Settings.page.admin_rooms_tb_size
  end

  def new
    @room_type = RoomType.new
  end

  def update
    if @room_type.update room_type_params
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
    @room_type = RoomType.new room_type_params
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
    params.require(:room_type).permit :name, :description, :cost, :image, :capacity, :size
  end
end
