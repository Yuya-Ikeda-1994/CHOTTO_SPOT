class CreateSpotsTags < ActiveRecord::Migration[6.1]
  def change
    create_table :spots_tags do |t|
      t.references :spot, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
