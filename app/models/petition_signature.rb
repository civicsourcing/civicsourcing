class PetitionSignature < ActiveRecord::Base
  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :user,
    is_parent: { permitted_children: [Comment] }

  belongs_to :petition, counter_cache: true
  belongs_to :user

  validates :comment, length: { maximum: 500 }
  validates :petition, presence: true
  validates :user, presence: true, uniqueness: { scope: :petition_id }

  def custom_feeds
    [user.feed, petition.initiative.feed]
  end
end
