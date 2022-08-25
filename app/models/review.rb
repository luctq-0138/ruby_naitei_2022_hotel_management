class Review < ApplicationRecord
  belongs_to :user
  belongs_to :room_type
  scope :newest, ->{order created_at: :desc}
end
