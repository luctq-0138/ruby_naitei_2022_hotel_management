require "set"
class RoomTypesController < ApplicationController
  def index
    rooms = RoomType.search_room_type(session[:search])
    session.delete(:search)
    @pagy, @room_types = pagy rooms, items: Settings.page.default_size
  end

  def search
    capacity = params[:capacity]
    @room_types = RoomType.all.where("capacity >= #{capacity}")
    @room_type_availables = @room_types.select do |room_type|
      check_room_type_available(room_type, params[:room_type][:date_in], params[:room_type][:date_out])
    end

    store_search(@room_type_availables.map(&:id))
    redirect_to room_types_path
  end

  def check_room_type_available room_type, check_in, check_out
    rooms = room_type.rooms
    room_availables = rooms.select do |room|
      check_available(room, check_in, check_out)
    end
    return true unless room_availables.length.zero?

    false
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

  def find_room_type_from_booking; end

  def show
    @room_type = RoomType.find_by id: params[:id]
    if @room_type
      @list_rooms = @room_type.rooms
    else
      flash[:danger] = t ".find_fail"
      redirect_to room_types_path
    end
  end
end
