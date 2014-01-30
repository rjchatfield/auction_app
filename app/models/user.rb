class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  default_scope { order :last_name }

  has_many :items

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,   presence: true, length: { maximum: 50 }
  validates :email,       presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password,    presence: true, length: { minimum: 6 }

  has_secure_password

  def self.map_id_fname_lname
    all.map { |u| [u.id, u.first_name, u.last_name] }
  end

  # USED FOR REMEMBERING SESSIONS
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # USED FOR REMEMBERING SESSIONS
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  # USED FOR REMEMBERING SESSIONS
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
