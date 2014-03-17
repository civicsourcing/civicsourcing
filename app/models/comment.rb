class Comment < ActiveRecord::Base
  attr_accessor :commenter
  acts_as_eventable created_by: :commenter, is_child: true,
    is_parent: { permitted_children: [Comment] }

end
