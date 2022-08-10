class Booking < ApplicationRecord
  belongs_to :user
  has_one :payment, dependent: :destroy
  has_many :room_bookeds, dependent: :destroy
  has_many :rooms, through: :room_bookeds
end
