class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.references :user, null: false, foreign_key: true
      t.string :spot_name, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.string :comment

      t.timestamps
    end
  end
end
