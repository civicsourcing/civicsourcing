class PetitionDelivery < ActiveRecord::Base

  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :petition

  def custom_feeds
    [petition.initiative.feed]
  end
end
