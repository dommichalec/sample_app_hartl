class User < ApplicationRecord
  # Callbacks
  before_save {self.email = self.email.downcase}
  # ActiveRecord validations
  validates :first_name, :last_name, presence: true, length: { in: 1..30 }
  validates :email, presence: true, length: { in: 1..255 },
            format: { with: ApplicationRecord::VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false } # case doesn't matter here
  validates :password, :password_confirmation, presence: true,
            length: {minimum: 6}
  # use has_secure_password for hashed password and password_confirmation
  has_secure_password
end
