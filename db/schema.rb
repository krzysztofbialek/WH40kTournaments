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

ActiveRecord::Schema.define(:version => 20120909190930) do

  create_table "hostel_bookings", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.boolean  "payment",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "tournament_id"
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "league_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tournament_id"
  end

  create_table "team_registrations", :force => true do |t|
    t.integer  "team_id"
    t.boolean  "payment",       :default => false
    t.boolean  "rosters",       :default => false
    t.boolean  "rosters_valid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "accepted_at"
    t.boolean  "accepted",      :default => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournament_registrations", :force => true do |t|
    t.integer  "tournament_id"
    t.integer  "player_id"
    t.boolean  "payment_send",  :default => false
    t.boolean  "roster_send",   :default => false
    t.boolean  "roster_valid",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "army"
    t.string   "player_email"
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.string   "rank"
    t.datetime "start_date"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

end
