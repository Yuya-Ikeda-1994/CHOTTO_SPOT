class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name,        null: false
      t.string :last_name,         null: false
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :bio
      t.string :avater
      t.integer :gender, default: 0, null: false

      t.timestamps                null: false
    end
  end
end
