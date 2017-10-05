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

ActiveRecord::Schema.define(version: 20171005041653) do

  create_table "log_files", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "room_id"
    t.integer "visitor_count"
    t.integer "average_stay"
    t.bigint "log_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["log_file_id"], name: "index_rooms_on_log_file_id"
  end

  create_table "visitors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "visitor_id"
    t.integer "room_visits"
    t.integer "average_stay"
    t.bigint "log_file_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["log_file_id"], name: "index_visitors_on_log_file_id"
  end

  create_table "visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.bigint "room_id"
    t.bigint "visitor_id"
    t.integer "stay"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_visits_on_room_id"
    t.index ["visitor_id"], name: "index_visits_on_visitor_id"
  end

end
