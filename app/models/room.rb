class Room < ApplicationRecord
  belongs_to :room_type
  has_many :room_bookeds, dependent: :destroy
  has_many :bookings, through: :room_bookeds
  validates :number, presence: true,
                     numericality: {only_integer: true}
end
