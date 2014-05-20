class Post < ActiveRecord::Base
  attr_accessor :feed_id
  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :user

  validates :title, presence: true, length: { in: 3..160 }
  validates :body, presence: true, length: { minimum: 1 }

  after_create :add_badges, :add_points
  after_destroy :remove_badges, :subtract_points

  def custom_feeds
    [user.feed, feed]
  end

  def feed
    event.feeds.find_by(feedable_type: "Community") ||
      event.feeds.find_by(feedable_type: "Workroom") ||
      FlexibleFeeds::Feed.find(feed_id)
  end

  def community
    feed.feedable.community
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
    BadgeGranter.new(user: user, count: user.posts(true).count,
      qualifications: badge_qualifications)
  end

  def add_points
    user.add_points(5, category: 'Post')
    community.add_points(5) if community.present?
  end

  def subtract_points
    user.subtract_points(5, category: 'Post')
    community.subtract_points(5) if community.present?
  end

end
