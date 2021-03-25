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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20210318214111) do

  create_table "base_rates", :force => true do |t|
    t.decimal  "rate"
    t.date     "date_begin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "billings", :force => true do |t|
    t.decimal  "total_amount"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "day_rates", :force => true do |t|
    t.string   "name"
    t.decimal  "rate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "client_id"
    t.date     "reserved_at"
    t.date     "date_in"
    t.date     "date_out"
    t.text     "demands"
    t.integer  "billing_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reserved_rooms", :force => true do |t|
    t.integer  "room_id"
    t.integer  "reservation_id"
    t.date     "deleted_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "room_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.integer  "next_door"
    t.integer  "floor"
    t.integer  "view_type_id"
    t.integer  "room_type_id"
    t.integer  "base_rate_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "season_rates", :force => true do |t|
    t.string   "name"
    t.decimal  "rate"
    t.date     "from_date"
    t.date     "to_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "view_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
