class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by_email(email)

    return unless user && user.authenticate(password)

    user
  end
end
