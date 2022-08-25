class Room < ApplicationRecord
  belongs_to :room_type
  has_many :room_bookeds, dependent: :destroy
  has_many :bookings, through: :room_bookeds
  scope :newest, ->{order created_at: :desc}
end
