# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_02_21_013359) do

  create_table "feedbacks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "spot_id", null: false
    t.string "feedback_comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_feedbacks_on_spot_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "spot_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_likes_on_spot_id"
    t.index ["user_id", "spot_id"], name: "index_likes_on_user_id_and_spot_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "spot_images", force: :cascade do |t|
    t.integer "spot_id", null: false
    t.string "image", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_spot_images_on_spot_id"
  end

  create_table "spots", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "spot_name", null: false
    t.string "address", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "spots_tags", force: :cascade do |t|
    t.integer "spot_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["spot_id"], name: "index_spots_tags_on_spot_id"
    t.index ["tag_id"], name: "index_spots_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.integer "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "bio"
    t.string "avater"
    t.integer "gender", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "feedbacks", "spots"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "likes", "spots"
  add_foreign_key "likes", "users"
  add_foreign_key "spot_images", "spots"
  add_foreign_key "spots", "users"
  add_foreign_key "spots_tags", "spots"
  add_foreign_key "spots_tags", "tags"
end
