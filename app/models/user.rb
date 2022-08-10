class User < ApplicationRecord
  has_many :payments, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_secure_password
end
