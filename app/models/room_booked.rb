class RoomBooked < ApplicationRecord
  belongs_to :room
  belongs_to :booking
end
