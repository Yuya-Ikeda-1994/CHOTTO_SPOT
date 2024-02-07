class Spot < ApplicationRecord
  belongs_to :user

  validates :spot_name, presence: true
  validates :address, presence: true
end
