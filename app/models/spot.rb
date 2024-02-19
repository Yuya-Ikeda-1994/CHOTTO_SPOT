class Spot < ApplicationRecord
  belongs_to :user
  has_many :spot_images, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :spots_tags, dependent: :destroy
  has_many :tags, through: :spots_tags
  accepts_nested_attributes_for :spot_images, allow_destroy: true

  validates :spot_name, presence: true
  validates :address, presence: true
end
