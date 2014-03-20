class Comment < ActiveRecord::Base
  attr_accessor :creator, :parent_event_id
  acts_as_eventable created_by: :creator, is_child: true,
    is_parent: { permitted_children: [Comment] }

  after_create :post_to_parent

  private
  def post_to_parent
    parent = FlexibleFeeds::Event.find(parent_event_id)
    @comment.child_of(parent)
  end
end
