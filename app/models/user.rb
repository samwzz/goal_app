class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  validates :session_token, presence: true
  after_initialize :ensure_session_token

  attr_reader :password

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password).to_s
    self.password_digest
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user.password_digest.is_password?(password)
      return user
    else
      nil
    end
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.session_token
  end

end
