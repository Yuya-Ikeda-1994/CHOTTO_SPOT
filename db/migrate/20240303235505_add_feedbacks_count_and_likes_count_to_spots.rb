class AddFeedbacksCountAndLikesCountToSpots < ActiveRecord::Migration[6.1]
  def change
    add_column :spots, :feedbacks_count, :integer, default: 0, null: false
    add_column :spots, :likes_count, :integer, default: 0, null: false
  end
end
