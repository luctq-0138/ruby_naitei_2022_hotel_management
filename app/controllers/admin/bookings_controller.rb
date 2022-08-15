class Admin::BookingsController < Admin::BaseController
  def index
    @pagy, @bookings = pagy Booking.all, page: params[:page],
                                         items: Settings.page.admin_booking_tb_size
  end
end
