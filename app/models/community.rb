class Community < ActiveRecord::Base
  attr_accessor :creator

  extend FriendlyId
  friendly_id :name, use: :history

  acts_as_group

  flexible_feeds

  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }

  belongs_to :upload

  has_many :initiatives
  belongs_to :founder, class_name: "User"

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  after_create :create_creator_membership, :add_badges
  after_destroy :remove_badges

  def custom_feeds
    [creator.feed, feed]
  end

  private
  def badge_qualifications
    [
      { prerequisite: 1, badge: 16 }
    ]
  end

  def add_badges
    badge_granter.add_badges
  end

  def remove_badges
    badge_granter.remove_badges
  end

  def badge_granter
    create_event_if_nil
    count = creator.founded_communities(true).count
    BadgeGranter.new(user: creator, count: count,
      qualifications: badge_qualifications)
  end

  def create_creator_membership
    add_officer(creator)
    creator.follow(feed)
  end
end
