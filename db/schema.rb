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

ActiveRecord::Schema.define(:version => 4) do

  create_table "activities", :force => true do |t|
    t.string   "name",                          :null => false
    t.integer  "user_id",                       :null => false
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "products_count", :default => 0
    t.string   "token",                         :null => false
  end

  create_table "authentication", :force => true do |t|
    t.string  "provider"
    t.string  "uid"
    t.integer "user_id"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "product_sku_id"
    t.integer  "number"
    t.integer  "buyer_id",       :null => false
    t.string   "buyer_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_skus", :force => true do |t|
    t.integer  "product_id",                   :null => false
    t.string   "color"
    t.string   "size"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "selled_number", :default => 0
  end

  create_table "products", :force => true do |t|
    t.string   "name",           :null => false
    t.text     "description"
    t.string   "purchase_price"
    t.string   "sell_price"
    t.string   "taobao_link"
    t.string   "product_link"
    t.integer  "user_id",        :null => false
    t.integer  "activity_id"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nickname",               :limit => 16,                 :null => false
    t.string   "email",                  :limit => 30,                 :null => false
    t.string   "password_digest",        :limit => 128,                :null => false
    t.string   "phone"
    t.string   "reset_password_token"
    t.datetime "reset_password_send_at"
    t.datetime "remember_created_at"
    t.datetime "last_sign_in_at"
    t.datetime "current_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar"
    t.integer  "role",                                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
