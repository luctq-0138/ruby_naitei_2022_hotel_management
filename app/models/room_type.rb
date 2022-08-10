class RoomType < ApplicationRecord
  has_one :room, dependent: :destroy
end
