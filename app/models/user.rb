class User < ApplicationRecord

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :username, uniqueness: true

  after_initialize :ensure_session_token

  has_many :goals
  has_many :comments
  
  attr_reader :password

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      return user
    end
    nil
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def is_password?(password)
    bcrypt_pass = BCrypt::Password.new(self.password_digest)
    bcrypt_pass.is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
