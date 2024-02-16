class Spot < ApplicationRecord
  belongs_to :user
  has_many :spot_images, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  accepts_nested_attributes_for :spot_images, allow_destroy: true

  validates :spot_name, presence: true
  validates :address, presence: true
end