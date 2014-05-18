class Task < ActiveRecord::Base
  
  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :user
  belongs_to :workroom

  def custom_feeds
    [workroom.feed]
  end
end
