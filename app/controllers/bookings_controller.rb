class BookingsController < ApplicationController
  before_action :logged_in_user, :must_be_user

  def new
    @booking = session[:booking]
    @check_in = session[:booking]["check_in"]
    @room_type = find_room_type @booking["room_type"]
    @rooms = @booking["rooms"].map do |room_id|
      Room.find_by id: room_id
    end.compact
  end

  def create
    handle_save_booking
    session.delete(:booking)
    flash[:success] = t ".booking_success"
    redirect_to room_types_path
  end

  def save_booking_session
    booking = {
      check_in: params[:booking][:date_in],
      check_out: params[:booking][:date_out],
      rooms: params[:booking][:input_rooms].from(1).split("@"),
      room_type: params[:booking][:room_type]
    }
    session[:booking] = booking
    redirect_to new_booking_path
  end

  def index
    @pagy, @bookings = pagy current_user.bookings.not_cancel, page: params[:page],
                                         items: Settings.page.admin_booking_tb_size
  end

  def destroy
    booking = find_booking params[:id]
    if booking.cancel!
      flash[:success] = t ".destroy_success"
    else
      flash[:error] = t ".destroy_fail"
    end
    redirect_to bookings_path
  end

  private

  def get_booking_from_session
    booking_date = Time.zone.today.strftime(Settings.date.format)
    check_in = session[:booking]["check_in"]
    check_out = session[:booking]["check_out"]
    booking = current_user.bookings.create(booking_date: booking_date,
                                           check_in: check_in,
                                           check_out: check_out)
    return booking if booking

    flash[:danger] = t ".booking_error"
    redirect_to new_booking_path
  end

  def handle_save_booking
    booking = get_booking_from_session
    session[:booking]["rooms"].each do |room_id|
      room = find_room room_id
      unless booking.room_bookeds.create(room: room)
        flash[:danger] = t ".booking_error"
        redirect_to new_booking_path
      end
    end
  end

  def find_room_type room_type_id
    room_type = RoomType.find_by id: room_type_id
    return room_type if room_type

    flash[:danger] = t ".not_found_room_type"
    redirect_to new_booking_path
  end

  def find_room room_id
    room = Room.find_by id: room_id
    return room if room

    flash[:danger] = t ".not_found_room"
    redirect_to new_booking_path
  end

  def find_booking booking_id
    booking = Booking.find_by id: booking_id
    return booking if booking

    flash[:danger] = t ".destroy_fail"
    redirect_to bookings_path
  end
end
