class Post < ActiveRecord::Base
  attr_accessor :poster, :feed_id
  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :poster,
    is_parent: { permitted_children: [Comment] }

  def custom_feeds
    [poster.feed, FlexibleFeeds::Feed.find(feed_id)]
  end

end
