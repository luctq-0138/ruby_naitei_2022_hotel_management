class Booking < ApplicationRecord
  enum status: {pending: 0, approve: 1, refuse: 2, cancel: 3, paid: 4}
  delegate :name, to: :user, prefix: true
  delegate :email, to: :user, prefix: true
  belongs_to :user
  has_one :payment, dependent: :destroy
  has_many :room_bookeds, dependent: :destroy
  has_many :rooms, through: :room_bookeds
end
