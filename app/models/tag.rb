class Tag < ApplicationRecord
    enum content: { 屋外: 0, 屋内: 1, 飲食可: 2, 屋根: 3, テーブル: 4, 冷暖房: 5, 自動販売機: 6, トイレ: 7 }

    def self.ransackable_attributes(auth_object = nil)
      ["content", "created_at", "id", "updated_at"]
    end
end
