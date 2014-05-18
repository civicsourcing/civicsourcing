class Initiative < ActiveRecord::Base
  include Feature

  extend FriendlyId
  friendly_id :name, use: :history
  
  acts_as_group

  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :upload
  belongs_to :community
  belongs_to :user

  has_one :fund
  has_one :petition
  has_one :workroom
  has_one :feed, through: :workroom

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :community, presence: true

  validate :user_is_a_member_of_the_community

  after_create :create_workroom, :create_user_membership, :add_badges, :add_points
  after_destroy :remove_badges, :subtract_points

  def custom_feeds
    [user.feed, community.feed]
  end

  private
  def badge_qualifications
    [
      { prerequisite: 1, badge: 6 }
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
    count = user.founded_initiatives(true).count
    BadgeGranter.new(user: user, count: count,
      qualifications: badge_qualifications)
  end

  def user_is_a_member_of_the_community
    unless community.present? && Adhocracy::Membership.where(
      member_type: user.class.name,
      member_id: user.id,
      group_type: community.class.name,
      group_id: community.id).exists?
        errors.add(:community, "must be a community that you belong to")
    end
  end

  def create_user_membership
    add_officer(user)
    user.follow(feed)
  end

  def add_points
    user.add_points(20, category: 'Initiative')
    community.add_points(20)
  end

  def subtract_points
    user.subtract_points(20, category: 'Initiative')
    community.subtract_points(20)
  end
end
