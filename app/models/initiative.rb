class Initiative < ActiveRecord::Base
  include Feature
  
  attr_accessor :creator

  extend FriendlyId
  friendly_id :name, use: :history
  
  acts_as_group

  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }

  belongs_to :upload
  belongs_to :community

  has_one :fund
  has_one :petition
  has_one :workroom
  has_one :feed, through: :workroom

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :community, presence: true

  validate :creator_is_a_member_of_the_community

  after_create :create_workroom, :create_creator_membership, :add_badges
  after_destroy :remove_badges

  def custom_feeds
    [creator.feed, community.feed]
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
    count = creator.founded_initiatives(true).count
    BadgeGranter.new(user: creator, count: count,
      qualifications: badge_qualifications)
  end

  def creator_is_a_member_of_the_community
    unless community.present? && Adhocracy::Membership.where(
      member_type: creator.class.name,
      member_id: creator.id,
      group_type: community.class.name,
      group_id: community.id).exists?
        errors.add(:community, "must be a community that you belong to")
    end
  end

  def create_creator_membership
    add_officer(creator)
    creator.follow(feed)
  end
end
