module RoomTypesHelper
  def check_review room_type_id
    return false unless current_user

    current_user.bookings.includes(:rooms).each do |booking|
      return false unless Booking.statuses[booking.status] == Booking.statuses[:paid]

      booking.rooms.each do |room|
        return true if room.room_type_id == room_type_id
      end
    end
    false
  end
end
