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
  belongs_to :community_category

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :community_category, presence: true

  after_create :create_creator_membership, :add_badges
  after_destroy :remove_badges

  def custom_feeds
    [creator.feed, feed]
  end

  def self.calculate_scores
    Community.all.each do |community|
      community.update_score
    end
  end

  def update_score
    score = 0
    members.each{ |member| score += member.points }
    update_column(:score, score)
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
    count = creator.founded_communities(true).count
    BadgeGranter.new(user: creator, count: count,
      qualifications: badge_qualifications)
  end

  def create_creator_membership
    add_officer(creator)
    creator.follow(feed)
  end
end
