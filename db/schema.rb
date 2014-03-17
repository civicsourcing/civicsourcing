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

ActiveRecord::Schema.define(version: 20140315180315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adhocracy_membership_invitations", force: true do |t|
    t.string   "member_type"
    t.integer  "member_id"
    t.string   "group_type"
    t.integer  "group_id"
    t.boolean  "pending",     default: true,  null: false
    t.boolean  "accepted",    default: false, null: false
    t.boolean  "declined",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adhocracy_membership_invitations", ["member_id", "member_type"], name: "adhocracy_membership_invitations_on_member", using: :btree

  create_table "adhocracy_membership_requests", force: true do |t|
    t.string   "member_type"
    t.integer  "member_id"
    t.string   "group_type"
    t.integer  "group_id"
    t.boolean  "pending",     default: true,  null: false
    t.boolean  "accepted",    default: false, null: false
    t.boolean  "declined",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adhocracy_membership_requests", ["member_id", "member_type"], name: "adhocracy_membership_requests_on_member", using: :btree

  create_table "adhocracy_memberships", force: true do |t|
    t.string   "member_type"
    t.integer  "member_id"
    t.string   "group_type"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adhocracy_memberships", ["group_id", "group_type"], name: "adhocracy_membership_invitations_on_group", using: :btree
  add_index "adhocracy_memberships", ["group_id", "group_type"], name: "adhocracy_membership_requests_on_group", using: :btree
  add_index "adhocracy_memberships", ["group_id", "group_type"], name: "adhocracy_memberships_on_group", using: :btree
  add_index "adhocracy_memberships", ["member_id", "member_type"], name: "adhocracy_memberships_on_member", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communities", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "private",               default: false, null: false
    t.integer  "upload_id"
    t.integer  "completed_initiatives", default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "communities", ["name"], name: "index_communities_on_name", using: :btree
  add_index "communities", ["private"], name: "index_communities_on_private", using: :btree
  add_index "communities", ["slug"], name: "index_communities_on_slug", unique: true, using: :btree

  create_table "flexible_feeds_event_joins", force: true do |t|
    t.integer  "feed_id"
    t.integer  "event_id"
    t.boolean  "sticky",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexible_feeds_event_joins", ["event_id"], name: "index_flexible_feeds_event_joins_on_event_id", using: :btree
  add_index "flexible_feeds_event_joins", ["feed_id"], name: "index_flexible_feeds_event_joins_on_feed_id", using: :btree
  add_index "flexible_feeds_event_joins", ["sticky"], name: "index_flexible_feeds_event_joins_on_sticky", using: :btree

  create_table "flexible_feeds_events", force: true do |t|
    t.string   "eventable_type"
    t.integer  "eventable_id"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.integer  "parent_id"
    t.integer  "ancestor_id"
    t.integer  "children_count", default: 0,   null: false
    t.integer  "votes_sum",      default: 0,   null: false
    t.integer  "votes_for",      default: 0,   null: false
    t.integer  "votes_against",  default: 0,   null: false
    t.float    "controversy",    default: 0.0, null: false
    t.float    "popularity",     default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexible_feeds_events", ["ancestor_id"], name: "index_flexible_feeds_events_on_ancestor_id", using: :btree
  add_index "flexible_feeds_events", ["children_count"], name: "index_flexible_feeds_events_on_children_count", using: :btree
  add_index "flexible_feeds_events", ["controversy"], name: "index_flexible_feeds_events_on_controversy", using: :btree
  add_index "flexible_feeds_events", ["creator_id", "creator_type"], name: "flexible_feeds_events_on_creator", using: :btree
  add_index "flexible_feeds_events", ["eventable_id", "eventable_type"], name: "flexible_feeds_events_on_eventable", using: :btree
  add_index "flexible_feeds_events", ["parent_id"], name: "index_flexible_feeds_events_on_parent_id", using: :btree
  add_index "flexible_feeds_events", ["popularity"], name: "index_flexible_feeds_events_on_popularity", using: :btree
  add_index "flexible_feeds_events", ["votes_against"], name: "index_flexible_feeds_events_on_votes_against", using: :btree
  add_index "flexible_feeds_events", ["votes_for"], name: "index_flexible_feeds_events_on_votes_for", using: :btree
  add_index "flexible_feeds_events", ["votes_sum"], name: "index_flexible_feeds_events_on_votes_sum", using: :btree

  create_table "flexible_feeds_feeds", force: true do |t|
    t.string   "feedable_type"
    t.integer  "feedable_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexible_feeds_feeds", ["feedable_id", "feedable_type"], name: "flexible_feeds_feeds_on_parent", using: :btree
  add_index "flexible_feeds_feeds", ["name"], name: "index_flexible_feeds_feeds_on_name", using: :btree

  create_table "flexible_feeds_follows", force: true do |t|
    t.integer  "feed_id"
    t.integer  "follower_id"
    t.string   "follower_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexible_feeds_follows", ["feed_id"], name: "index_flexible_feeds_follows_on_feed_id", using: :btree
  add_index "flexible_feeds_follows", ["follower_id", "follower_type"], name: "flexible_feeds_follows_on_follower", using: :btree

  create_table "flexible_feeds_moderator_joins", force: true do |t|
    t.integer  "feed_id"
    t.integer  "moderator_id"
    t.string   "moderator_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexible_feeds_moderator_joins", ["feed_id"], name: "index_flexible_feeds_moderator_joins_on_feed_id", using: :btree
  add_index "flexible_feeds_moderator_joins", ["moderator_id", "moderator_type"], name: "flexible_feeds_moderator_joins_on_moderator", using: :btree

  create_table "flexible_feeds_votes", force: true do |t|
    t.integer  "event_id"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.integer  "value",      default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexible_feeds_votes", ["event_id"], name: "index_flexible_feeds_votes_on_event_id", using: :btree
  add_index "flexible_feeds_votes", ["voter_id", "voter_type"], name: "flexible_feeds_votes_on_voter", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.string "file"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "slug"
    t.integer  "upload_id"
    t.string   "authentication_token"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
