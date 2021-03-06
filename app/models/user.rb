class User < ActiveRecord::Base
  before_create :create_token
  before_save { self.email = email.downcase}
  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: 6}

  has_many :posts

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def forget
    self.remember_digest = nil
  end

  private
    def create_token
      self.remember_digest = User.digest(User.new_token)
    end


end
