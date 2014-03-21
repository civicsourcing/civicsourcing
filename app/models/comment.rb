class Comment < ActiveRecord::Base
  attr_accessor :creator, :parent_event_id
  acts_as_eventable created_by: :creator, is_child: true,
    is_parent: { permitted_children: [Comment] }

  after_create :post_to_parent, :add_badges
  after_destroy :remove_badges

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
    BadgeGranter.new(user: creator, count: creator.comments.count,
      qualifications: badge_qualifications)
  end
end
