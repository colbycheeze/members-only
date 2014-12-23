class User < ActiveRecord::Base
  before_save { self.email = email.downcase}
  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}
end
