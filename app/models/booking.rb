class Booking < ApplicationRecord
  enum status: {pending: 0, approve: 1, refuse: 2, cancel: 3, paid: 4}
  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true
  belongs_to :user
  has_one :payment, dependent: :destroy
  has_many :room_bookeds, dependent: :destroy
  has_many :rooms, through: :room_bookeds
  scope :newest, ->{order created_at: :desc}
  scope :search_booking_date, ->(booking_date){where("booking_date LIKE ?", "%#{booking_date}%") if booking_date.present?}
  scope :search_check_in, ->(check_in){where("check_in LIKE ?", "%#{check_in}%") if check_in.present?}
  scope :search_check_out, ->(check_out){where("check_out LIKE ?", "%#{check_out}%") if check_out.present?}
  scope :search_status, ->(status){where(status: status.to_s) if status.present?}
  scope :search, lambda {|params|
    search_booking_date(params[:booking_date])
      .search_check_in(params[:check_in])
      .search_check_out(params[:check_out])
      .search_status(params[:status])
  }
end
