class Community < ActiveRecord::Base

  extend FriendlyId
  friendly_id :name, use: :history

  acts_as_group

  flexible_feeds

  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :upload

  has_many :initiatives
  belongs_to :community_category
  belongs_to :user

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :community_category, presence: true

  after_create :create_user_membership, :add_badges
  after_destroy :remove_badges

  def community
    self
  end

  def custom_feeds
    [user.feed, feed]
  end

  def add_points(amount)
    increment(:score, amount)
    save
  end

  def subtract_points(amount)
    decrement(:score, amount)
    save
  end

  def overall_rank
    Community.all.order("score DESC").index(self) + 1
  end

  def category_rank
    Community.where(community_category: community_category).order("score DESC").
      index(self) + 1
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
    count = user.founded_communities(true).count
    BadgeGranter.new(user: user, count: count,
      qualifications: badge_qualifications)
  end

  def create_user_membership
    add_officer(user)
    user.follow(feed)
  end
end
