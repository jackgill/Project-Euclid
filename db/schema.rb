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

ActiveRecord::Schema.define(:version => 20111228040317) do

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.integer  "lister_id"
    t.integer  "spot_id"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "ask_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "building_id"
    t.boolean  "taken",       :default => false, :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "requester_id", :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "bid_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spots", :force => true do |t|
    t.integer  "number"
    t.integer  "floor"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "building_id", :default => 0, :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "spot_id"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "login"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",        :default => false, :null => false
  end

end
