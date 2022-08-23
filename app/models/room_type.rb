class RoomType < ApplicationRecord
  has_many :rooms, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
end
