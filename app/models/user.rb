class User < ApplicationRecord
  attr_accessor :remember_token

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

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def admin?
    role == 1
  end

  def user?
    role.zero?
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false if digest.blank?

    BCrypt::Password.new(digest).is_password?(token)
  end

  private

  def downcase_email
    email.downcase!
  end
end
