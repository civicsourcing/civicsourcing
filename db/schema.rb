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

ActiveRecord::Schema.define(version: 20140418162755) do

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
    t.boolean  "officer",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adhocracy_memberships", ["group_id", "group_type"], name: "adhocracy_membership_invitations_on_group", using: :btree
  add_index "adhocracy_memberships", ["group_id", "group_type"], name: "adhocracy_membership_requests_on_group", using: :btree
  add_index "adhocracy_memberships", ["group_id", "group_type"], name: "adhocracy_memberships_on_group", using: :btree
  add_index "adhocracy_memberships", ["member_id", "member_type"], name: "adhocracy_memberships_on_member", using: :btree
  add_index "adhocracy_memberships", ["officer"], name: "index_adhocracy_memberships_on_officer", using: :btree

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "communities", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "private",               default: false, null: false
    t.integer  "upload_id"
    t.integer  "completed_initiatives", default: 0,     null: false
    t.integer  "community_category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",                 default: 0,     null: false
  end

  add_index "communities", ["community_category_id"], name: "index_communities_on_community_category_id", using: :btree
  add_index "communities", ["name"], name: "index_communities_on_name", using: :btree
  add_index "communities", ["private"], name: "index_communities_on_private", using: :btree
  add_index "communities", ["score"], name: "index_communities_on_score", using: :btree
  add_index "communities", ["slug"], name: "index_communities_on_slug", unique: true, using: :btree
  add_index "communities", ["user_id"], name: "index_communities_on_user_id", using: :btree

  create_table "community_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "community_categories", ["name"], name: "index_community_categories_on_name", using: :btree

  create_table "flexible_feeds_event_joins", force: true do |t|
    t.integer  "feed_id"
    t.integer  "event_id"
    t.boolean  "sticky",     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flexible_feeds_event_joins", ["event_id", "feed_id"], name: "flexible_feeds_event_joins_joinery", unique: true, using: :btree
  add_index "flexible_feeds_event_joins", ["sticky"], name: "index_flexible_feeds_event_joins_on_sticky", using: :btree

  create_table "flexible_feeds_events", force: true do |t|
    t.string   "eventable_type"
    t.integer  "eventable_id"
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

  create_table "fund_donations", force: true do |t|
    t.integer  "fund_id"
    t.integer  "user_id"
    t.integer  "fund_reward_id"
    t.integer  "amount"
    t.boolean  "paid",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fund_donations", ["fund_id"], name: "index_fund_donations_on_fund_id", using: :btree
  add_index "fund_donations", ["fund_reward_id"], name: "index_fund_donations_on_fund_reward_id", using: :btree
  add_index "fund_donations", ["paid"], name: "index_fund_donations_on_paid", using: :btree
  add_index "fund_donations", ["user_id"], name: "index_fund_donations_on_user_id", using: :btree

  create_table "fund_rewards", force: true do |t|
    t.integer  "fund_id"
    t.integer  "minimum_donation"
    t.text     "description"
    t.integer  "limit"
    t.integer  "fund_donations_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fund_rewards", ["fund_id"], name: "index_fund_rewards_on_fund_id", using: :btree

  create_table "funds", force: true do |t|
    t.boolean  "admin_approved",  default: false, null: false
    t.boolean  "active",          default: false, null: false
    t.integer  "goal"
    t.integer  "stretch_goal"
    t.datetime "end_date"
    t.text     "body"
    t.string   "title"
    t.integer  "initiative_id"
    t.integer  "total_donations", default: 0,     null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",        default: false, null: false
    t.string   "slug"
  end

  add_index "funds", ["active"], name: "index_funds_on_active", using: :btree
  add_index "funds", ["end_date"], name: "index_funds_on_end_date", using: :btree
  add_index "funds", ["featured"], name: "index_funds_on_featured", using: :btree
  add_index "funds", ["initiative_id"], name: "index_funds_on_initiative_id", using: :btree
  add_index "funds", ["slug"], name: "index_funds_on_slug", using: :btree
  add_index "funds", ["user_id"], name: "index_funds_on_user_id", using: :btree

  create_table "initiatives", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "description"
    t.integer  "community_id"
    t.integer  "upload_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",     default: false, null: false
  end

  add_index "initiatives", ["community_id"], name: "index_initiatives_on_community_id", using: :btree
  add_index "initiatives", ["featured"], name: "index_initiatives_on_featured", using: :btree
  add_index "initiatives", ["slug"], name: "index_initiatives_on_slug", unique: true, using: :btree
  add_index "initiatives", ["user_id"], name: "index_initiatives_on_user_id", using: :btree

  create_table "membership_request_responses", force: true do |t|
    t.integer  "membership_request_id"
    t.boolean  "accepted",              default: false, null: false
    t.text     "notes"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "membership_request_responses", ["user_id"], name: "index_membership_request_responses_on_user_id", using: :btree

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "petition_deliveries", force: true do |t|
    t.integer  "petition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "petition_deliveries", ["petition_id"], name: "index_petition_deliveries_on_petition_id", using: :btree

  create_table "petition_signatures", force: true do |t|
    t.integer  "petition_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "petition_signatures", ["petition_id"], name: "index_petition_signatures_on_petition_id", using: :btree
  add_index "petition_signatures", ["user_id"], name: "index_petition_signatures_on_user_id", using: :btree

  create_table "petitions", force: true do |t|
    t.integer  "initiative_id"
    t.string   "title"
    t.text     "body"
    t.integer  "goal"
    t.datetime "delivery_date"
    t.string   "deliver_to"
    t.integer  "petition_signatures_count", default: 0,     null: false
    t.boolean  "delivered",                 default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured",                  default: false, null: false
    t.string   "slug"
  end

  add_index "petitions", ["delivered"], name: "index_petitions_on_delivered", using: :btree
  add_index "petitions", ["delivery_date"], name: "index_petitions_on_delivery_date", using: :btree
  add_index "petitions", ["featured"], name: "index_petitions_on_featured", using: :btree
  add_index "petitions", ["initiative_id"], name: "index_petitions_on_initiative_id", using: :btree
  add_index "petitions", ["slug"], name: "index_petitions_on_slug", using: :btree
  add_index "petitions", ["user_id"], name: "index_petitions_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "workroom_id"
    t.string   "name"
    t.boolean  "completed",   default: false, null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree
  add_index "tasks", ["workroom_id"], name: "index_tasks_on_workroom_id", using: :btree

  create_table "uploads", force: true do |t|
    t.string "file"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "slug"
    t.string   "gender",                 default: "male", null: false
    t.boolean  "admin",                  default: false,  null: false
    t.integer  "upload_id"
    t.string   "authentication_token"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,      null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_href"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "workrooms", force: true do |t|
    t.integer  "initiative_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workrooms", ["initiative_id"], name: "index_workrooms_on_initiative_id", using: :btree

end
