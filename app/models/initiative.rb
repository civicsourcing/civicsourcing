class Initiative < ActiveRecord::Base
  attr_accessor :creator

  extend FriendlyId
  friendly_id :name, use: :history
  
  acts_as_group

  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }

  belongs_to :upload
  belongs_to :community

  has_one :workroom

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
  validates :community, presence: true

  validate :creator_is_a_member_of_the_community

  after_create :create_workroom

  def custom_feeds
    [creator.feed, community.feed]
  end

  private
  def creator_is_a_member_of_the_community
    unless Adhocracy::Membership.where(
      member_type: creator.class.name,
      member_id: creator.id,
      group_type: community.class.name,
      group_id: community.id).exists?
        errors.add(:community, "must be a community that you belong to")
    end
  end
end
