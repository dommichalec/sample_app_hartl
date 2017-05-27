class User < ApplicationRecord
  attr_accessor :remember_token
  # Callbacks
  before_save {self.email = self.email.downcase}
  # use has_secure_password for hashed password and password_confirmation
  has_secure_password
  # ActiveRecord validations
  validates :first_name, :last_name, presence: true, length: { in: 1..30 }
  validates :email, presence: true, length: { in: 1..255 },
            format: { with: ApplicationRecord::VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false } # case doesn't matter here
  validates :password, presence: true,
            length: {minimum: 6}, allow_nil: true # allows for blank password
            # and password_confirmation for updating users

  # returns a string of the user's first name and last name
  def full_name
    first_name + " " + last_name
  end

  # Remembers a user in the database for use in persistent sessions.
  # updates remember_digest with a hashed version of the string "remember_token"
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end
end
