class Post < ActiveRecord::Base
  attr_accessor :creator, :feed_id
  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }

  validates :title, presence: true, length: { in: 3..160 }
  validates :body, presence: true, length: { minimum: 1 }

  after_create :add_badges
  after_destroy :remove_badges

  def custom_feeds
    [creator.feed, FlexibleFeeds::Feed.find(feed_id)]
  end

  private
  def badge_qualifications
    [
      { prerequisite: 1, badge: 16 }
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
    BadgeGranter.new(user: creator, count: creator.posts(true).count,
      qualifications: badge_qualifications)
  end

end
