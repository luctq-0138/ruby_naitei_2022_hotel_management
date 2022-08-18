class Admin::BookingsController < Admin::BaseController
  include BookingsHelper
  before_action :find_booking, only: [:show, :edit, :update]
  def index
    @pagy, @bookings = pagy Booking.all.newest, page: params[:page],
                                         items: Settings.page.admin_booking_tb_size
  end

  def show
    @list_rooms = @booking.rooms
  end

  def edit; end

  def update
    if @booking.update status: params[:booking_status].to_i
      flash[:success] = t "booking_update_success"
      redirect_to admin_bookings_path
    else
      flash[:danger] = t "booking_update_fail"
      render :edit
    end
  end

  private

  def find_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:danger] = t "booking_not_found"
    redirect_to admin_bookings_path
  end
end
