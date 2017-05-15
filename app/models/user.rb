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

  # returns a string of the user's first name and last name
  def full_name
    first_name + " " + last_name
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
