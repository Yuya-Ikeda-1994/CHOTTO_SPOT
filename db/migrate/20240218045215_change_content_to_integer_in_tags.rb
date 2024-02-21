class ChangeContentToIntegerInTags < ActiveRecord::Migration[6.1]
  def change
    change_column :tags, :content, :integer, using: 'content::integer'
  end
end
