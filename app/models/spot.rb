class Spot < ApplicationRecord
  belongs_to :user
  has_many :spot_images, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :spots_tags, dependent: :destroy
  has_many :tags, through: :spots_tags
  accepts_nested_attributes_for :spot_images, allow_destroy: true
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :spot_name, presence: true
  validates :address, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "comment", "created_at", "id", "latitude", "longitude", "spot_name", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["feedbacks", "spot_images", "spots_tags", "tags", "user"]
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
