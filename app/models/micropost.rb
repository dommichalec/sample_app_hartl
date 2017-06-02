class Micropost < ApplicationRecord
  # Callbacks
  before_save { validate :picture_size }
  # Associations
  belongs_to :user
  # ActiveRecord validations
  validates :user_id, presence: true
  validates :content, presence: true, length: { in: 1..140 }

  # Scopes
  default_scope -> { order(created_at: :desc) }
  # mount_uploader takes as arguments a symbol representing the attribute and
  # the class name of the generated uploader
  mount_uploader :picture, PictureUploader

  private
  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
