class PetitionSignature < ActiveRecord::Base
  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :petition, counter_cache: true
  belongs_to :user

  validates :comment, length: { maximum: 500 }
  validates :petition, presence: true
  validates :user, presence: true, uniqueness: { scope: :petition_id }

  after_create :add_points
  after_destroy :subtract_points

  def custom_feeds
    [user.feed, petition.initiative.feed]
  end

  def community
    petition.community
  end

  private
  def add_points
    user.add_points(5, category: 'PetitionSignature')
    community.add_points(5)
  end

  def subtract_points
    user.subtract_points(5, category: 'PetitionSignature')
    community.subtract_points(5)
  end
end
