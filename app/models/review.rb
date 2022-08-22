class Review < ApplicationRecord
  belongs_to :user
  belongs_to :room_type
end
