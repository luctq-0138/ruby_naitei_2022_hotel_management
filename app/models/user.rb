class User < ApplicationRecord
  has_many :payments, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_secure_password

  before_save :downcase_email

  validates :name, presence: true,
                   length: {maximum: Settings.valid.name_max_len}

  validates :email, presence: true,
                    format: {with: Settings.regex.email_regex},
                    uniqueness: {case_sensitive: false},
                    length: {maximum: Settings.valid.email_max_len}

  validates :password, presence: true,
                       length: {minimum: Settings.valid.password_min_len},
                       allow_nil: true

  private

  def downcase_email
    email.downcase!
  end
end
