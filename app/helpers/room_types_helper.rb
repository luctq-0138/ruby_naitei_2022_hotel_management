module RoomTypesHelper
  def check_review room_type_id
    return false unless current_user

    room_type = RoomType.find_by id: room_type_id
    rooms = room_type.rooms
    return false unless rooms

    rooms.each do |room|
      bookings = room.bookings
      next unless bookings

      bookings.each do |booking|
        return true if booking.user_id == current_user.id && Booking.statuses[booking.status] == Booking.statuses[:paid]
      end
    end
    false
  end
end
