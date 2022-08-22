class Review < ApplicationRecord
  belongs_to :user
  belongs_to :room_type
  delegate :name, to: :user, prefix: true
  validates :review, :star_rate, presence: true
end
