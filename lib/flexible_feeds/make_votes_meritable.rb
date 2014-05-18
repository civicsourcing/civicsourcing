require_dependency "lib/merit/badge_granter"
require_dependency FlexibleFeeds::Engine.root.join('app', 'models', 'flexible_feeds', 'vote').to_s

FlexibleFeeds::Vote.class_eval do
  after_create :add_badges, :add_points
  after_destroy :remove_badges, :subtract_points

  def feed
    event_feed = event.ancestor || event
    event_feed.feeds.find_by(feedable_type: "Community")
  end

  def community
    feed.feedable.community
  end

  private
  def badge_qualifications
    [
      { prerequisite: 10, badge: 21 },
      { prerequisite: 50, badge: 22 },
      { prerequisite: 250, badge: 23 },
      { prerequisite: 1250, badge: 24 },
      { prerequisite: 6250, badge: 25 }
    ]
  end

  def add_badges
    badge_granter.add_badges
  end

  def remove_badges
    badge_granter.remove_badges
  end

  def badge_granter
    BadgeGranter.new(user: voter, count: voter.votes.count,
      qualifications: badge_qualifications)
  end

  def add_points
    voter.add_points(1, category: 'Vote')
    community.add_points(1) if community.present?
  end

  def subtract_points
    voter.subtract_points(1, category: 'Vote')
    community.subtract_points(1) if community.present?
  end
end