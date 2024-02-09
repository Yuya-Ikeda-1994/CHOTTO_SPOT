class CreateSpotImages < ActiveRecord::Migration[6.1]
  def change
    create_table :spot_images do |t|
      t.references :spot, null: false, foreign_key: true
      t.string :image, null: false

      t.timestamps
    end
  end
end
