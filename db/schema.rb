# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160812161016) do

  create_table "assistants", force: :cascade do |t|
    t.string   "name"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assistants", ["order_id"], name: "index_assistants_on_order_id"

  create_table "cars", force: :cascade do |t|
    t.string   "model"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cars", ["order_id"], name: "index_cars_on_order_id"

  create_table "deceaseds", force: :cascade do |t|
    t.string   "name"
    t.date     "birthday"
    t.date     "deathday"
    t.string   "born_place"
    t.string   "registered_in"
    t.string   "registered_in_street"
    t.string   "death_place"
    t.integer  "corpse_kind"
    t.date     "funeral_day"
    t.time     "funeral_time"
    t.string   "funeral_place"
    t.string   "cemetery_name"
    t.string   "coffin_kind"
    t.integer  "crematorium_kind"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "coffin_prepare_by"
    t.string   "coffin_issued_by"
    t.string   "note"
    t.date     "flowerday"
    t.time     "flowertime"
    t.boolean  "pillow_take"
    t.boolean  "instruments_1"
    t.boolean  "instruments_2"
    t.boolean  "instruments_3"
    t.boolean  "instruments_4"
    t.date     "arrive_day"
    t.time     "arrive_time"
    t.string   "arrive_from"
    t.integer  "vase_issued_by"
    t.string   "invoice_company"
    t.string   "invoice_place"
    t.string   "invoice_street"
    t.string   "invoice_house"
    t.date     "exposure_day"
    t.time     "morgue_work_from"
    t.time     "morgue_work_to"
    t.date     "departure_day"
    t.time     "departure_time"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "kind"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "order_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "flowers", force: :cascade do |t|
    t.string  "kind"
    t.integer "price"
    t.string  "text"
    t.integer "order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "deceased_id"
    t.integer  "relative_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "relatives", force: :cascade do |t|
    t.string   "name"
    t.string   "relationship"
    t.string   "phone"
    t.string   "mobile"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

end
