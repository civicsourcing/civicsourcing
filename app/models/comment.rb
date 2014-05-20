class Comment < ActiveRecord::Base
  attr_accessor :parent_event_id
  acts_as_eventable is_child: true,
    is_parent: { permitted_children: [Comment] }

  belongs_to :user

  validates :body, presence: true, length: { minimum: 1 }

  after_create :post_to_parent, :add_badges, :add_points
  after_destroy :remove_badges, :subtract_points
  validate :is_not_parent, on: [:update, :destroy]

  def feed
    event.ancestor.feeds.find_by(feedable_type: "Community") ||
      FlexibleFeeds::Event.find(parent_event_id).feeds.find_by(feedable_type: "Community") ||
      event.ancestor.feeds.find_by(feedable_type: "Workroom") ||
      FlexibleFeeds::Event.find(parent_event_id).feeds.find_by(feedable_type: "Workroom")
  end

  def community
    feed.feedable.community
  end

  private
  def post_to_parent
    create_event_if_nil
    parent = FlexibleFeeds::Event.find(parent_event_id)
    child_of(parent)
  end

  def badge_qualifications
    [
      { prerequisite: 10, badge: 1 },
      { prerequisite: 50, badge: 2 },
      { prerequisite: 250, badge: 3 },
      { prerequisite: 1250, badge: 4 },
      { prerequisite: 6250, badge: 5 }
    ]
  end

  def add_badges
    badge_granter.add_badges
  end

  def remove_badges
    badge_granter.remove_badges
  end

  def badge_granter
    BadgeGranter.new(user: user, count: user.comments.count,
      qualifications: badge_qualifications)
  end

  def add_points
    user.add_points(3, category: 'Comment')
    community.add_points(3) if community.present?
  end

  def subtract_points
    user.subtract_points(3, category: 'Comment')
    community.subtract_points(3) if community.present?
  end

  def is_not_parent
    if event.children.present?
      errors[:base] << "Cannot edit this comment, as it has responses."
    end
  end
end
