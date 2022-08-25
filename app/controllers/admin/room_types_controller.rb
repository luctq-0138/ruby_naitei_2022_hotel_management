class Admin::RoomTypesController < Admin::BaseController
  before_action :find_room_type, only: %i(edit update destroy)

  def index
    @pagy, @room_types = pagy RoomType.search(params).newest, page: params[:page],
                                            items: Settings.page.admin_rooms_tb_size
  end

  def new
    @room_type = RoomType.new
  end

  def update
    if @room_type.update(room_type_params.except("rooms"))
      update_rooms(params[:room_type][:rooms].split(";"), params[:id])
      flash[:success] = "Cập nhật thành công"
      redirect_to admin_room_types_path
    else
      flash[:error] = "Cập nhật thất bại"
      render :edit
    end
  end

  def destroy
    if @room_type.destroy
      flash[:success] = t "Xóa thành công"
    else
      flash[:error] = t "Xóa thất bại"
    end
    redirect_to admin_room_types_path
  end

  def create
    @room_type = RoomType.new room_type_params.except("rooms")
    if @room_type.save
      @room_numbers = params[:room_type][:rooms].split(";")
      create_rooms(@room_numbers, @room_type)
      flash[:success] = t "Tạo phòng thành công"
      redirect_to admin_room_types_path
    else
      flash[:danger] = t "Tạo phòng thất bại"
      render :new
    end
  end

  def edit; end

  private
  def find_room_type
    @room_type = RoomType.find_by id: params[:id]
    return if @room_type

    flash[:danger] = t ".find_fail"
    redirect_to admin_room_types_path
  end

  def room_type_params
    params.require(:room_type).permit RoomType::ROOMTYPE_ATTRS
  end

  def create_rooms room_numbers, room_type
    room_numbers.each do |room_number|
      room_type.rooms.create(number: room_number)
    end
  end

  def update_rooms room_numbers, room_type_id
    old_room = Room.where(room_type_id: room_type_id)
    new_room_number = room_numbers
    new_room_number.each.with_index do |num, index|
      if old_room[index].present?
        old_room[index].update(number: num)
      else
        Room.create(number: num, room_type_id: room_type_id)
      end
    end
    old_room.map.with_index do |room, _index|
      room.destroy unless room.number.in?(new_room_number
                                .reject(&:empty?).map(&:to_i))
    end
  end
end
