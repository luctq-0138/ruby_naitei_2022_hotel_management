class RoomTypesController < ApplicationController
  def index
    @pagy, @room_types = pagy RoomType.all.newest, page: params[:page],
                                            items: Settings.page.default_size
  end

  def show
    @room_type = RoomType.find_by id: params[:id]
    if @room_type
      @list_rooms = @room_type.rooms
    else
      flash[:danger] = t ".find_fail"
      redirect_to room_types_path
    end
  end

  def get_room_available
    @check_in = params[:booking][:date_in]
    @check_out = params[:booking][:date_out]
    @room_type = RoomType.find_by id: params[:booking][:room_type]
    @rooms = @room_type.rooms
    @room_availables = @rooms.select do |room|
      check_available(room, @check_in, @check_out)
    end
    respond_to do |format|
      format.js
    end
  end

  def check_available room, check_in, check_out
    return true if room.bookings.length.zero?

    bookings = room.bookings
    bookings.each do |booking|
      next unless booking.approve?
      return false unless booking.check_in > check_out || booking.check_out < check_in
    end
    true
  end
end
