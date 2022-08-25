class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  enum role: {user: 0, admin: 1}
  has_many :payments, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_secure_password

  scope :search_name, ->(name){where("name LIKE ?", "%#{name}%") if name.present?}

  before_save :downcase_email
  before_create :create_activation_digest

  validates :name, presence: true,
                   length: {maximum: Settings.valid.name_max_len}

  validates :email, presence: true,
                    format: {with: Settings.regex.email_regex},
                    uniqueness: {case_sensitive: false},
                    length: {maximum: Settings.valid.email_max_len}

  validates :password, presence: true,
                       length: {minimum: Settings.valid.password_min_len},
                       allow_nil: true
  validates :phone_number, presence: true,
                           numericality: {only_integer: true}

  validates :address, presence: true

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

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def create_reset_disget
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token),
                   reset_sent_at: Time.zone.now
  end

  private

  def downcase_email
    email.downcase!
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
