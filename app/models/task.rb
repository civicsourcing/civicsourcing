class Task < ActiveRecord::Base
  attr_accessor :creator
  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }

  belongs_to :workroom

  def custom_feeds
    [workroom.feed]
  end
end
