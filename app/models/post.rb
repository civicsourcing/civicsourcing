class Post < ActiveRecord::Base
  attr_accessor :creator, :feed_id
  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }

  def custom_feeds
    [creator.feed, FlexibleFeeds::Feed.find(feed_id)]
  end

end
