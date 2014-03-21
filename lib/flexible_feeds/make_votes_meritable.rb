require_dependency "lib/merit/badge_granter"
require_dependency FlexibleFeeds::Engine.root.join('app', 'models', 'flexible_feeds', 'vote').to_s

FlexibleFeeds::Vote.class_eval do
  after_create :add_badges
  after_destroy :remove_badges

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
end