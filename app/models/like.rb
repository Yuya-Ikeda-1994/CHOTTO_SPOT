class Like < ApplicationRecord
  belongs_to :user
  belongs_to :spot, counter_cache: true

  validates_uniqueness_of :spot_id, scope: :user_id
end
