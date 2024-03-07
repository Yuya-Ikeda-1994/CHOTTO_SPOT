class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :spot, counter_cache: true
  validates :feedback_comment, presence: true, length: { maximum: 65_535 }
end
