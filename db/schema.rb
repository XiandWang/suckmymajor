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

ActiveRecord::Schema.define(version: 20151030185223) do

  create_table "bets", force: :cascade do |t|
    t.string   "status"
    t.boolean  "lying"
    t.text     "proof"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bets", ["user_id", "created_at"], name: "index_bets_on_user_id_and_created_at"
  add_index "bets", ["user_id"], name: "index_bets_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.string   "body"
    t.integer  "user_id",    null: false
    t.integer  "bet_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["bet_id"], name: "index_comments_on_bet_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "major_bet_relationships", force: :cascade do |t|
    t.integer  "bet_id"
    t.integer  "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "major_bet_relationships", ["bet_id"], name: "index_major_bet_relationships_on_bet_id"
  add_index "major_bet_relationships", ["major_id", "bet_id"], name: "index_major_bet_relationships_on_major_id_and_bet_id", unique: true
  add_index "major_bet_relationships", ["major_id"], name: "index_major_bet_relationships_on_major_id"

  create_table "majors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type"
    t.integer  "bet_id"
  end

  add_index "notifications", ["bet_id"], name: "index_notifications_on_bet_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "results", force: :cascade do |t|
    t.integer  "bet_id"
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "winner_major_id"
  end

  add_index "results", ["bet_id"], name: "index_results_on_bet_id"
  add_index "results", ["loser_id"], name: "index_results_on_loser_id"
  add_index "results", ["winner_id"], name: "index_results_on_winner_id"

  create_table "user_major_relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "major_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_major_relationships", ["major_id"], name: "index_user_major_relationships_on_major_id"
  add_index "user_major_relationships", ["user_id", "major_id"], name: "index_user_major_relationships_on_user_id_and_major_id", unique: true
  add_index "user_major_relationships", ["user_id"], name: "index_user_major_relationships_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
