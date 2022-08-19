class Booking < ApplicationRecord
  belongs_to :user
  enum status: {pending: 0, approve: 1, refuse: 2, cancel: 3}
  has_one :payment, dependent: :destroy
  has_many :room_bookeds, dependent: :destroy
  has_many :rooms, through: :room_bookeds
end
