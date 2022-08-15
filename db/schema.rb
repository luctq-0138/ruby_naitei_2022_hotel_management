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

ActiveRecord::Schema.define(version: 2022_08_14_154203) do

  create_table "bookings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "booking_date", null: false
    t.string "duration_of_stay", null: false
    t.datetime "check_in"
    t.datetime "checkout"
    t.integer "total_rooms_booked", null: false
    t.integer "status", default: 0, null: false
    t.bigint "user_id"
    t.text "refuse_reason"
    t.integer "user_star_rate"
    t.decimal "total_amount", precision: 10, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "booking_id"
    t.string "payment_type", null: false
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_payments_on_booking_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "room_bookeds", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "room_id"
    t.bigint "booking_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_room_bookeds_on_booking_id"
    t.index ["room_id"], name: "index_room_bookeds_on_room_id"
  end

  create_table "room_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "cost", precision: 10, scale: 2
    t.integer "size"
    t.integer "capacity"
    t.string "services"
    t.integer "star_rate"
    t.string "image"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "number", null: false
    t.string "name"
    t.boolean "is_available", default: true
    t.bigint "room_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_type_id"], name: "index_rooms_on_room_type_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.text "address"
    t.string "phone_number"
    t.boolean "activated", default: false
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "payments", "bookings"
  add_foreign_key "payments", "users"
  add_foreign_key "room_bookeds", "bookings"
  add_foreign_key "room_bookeds", "rooms"
  add_foreign_key "rooms", "room_types"
end
