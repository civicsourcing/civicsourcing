require_dependency "app/models/comment"
require_dependency "app/models/membership_request_response"
require_dependency FlexibleFeeds::Engine.root.join('lib', 'flexible_feeds', 'acts_as_eventable').to_s
require_dependency FlexibleFeeds::Engine.root.join('app', 'models', 'flexible_feeds', 'feed').to_s
require_dependency Adhocracy::Engine.root.join('app', 'models', 'adhocracy', 'membership_request').to_s

Adhocracy::MembershipRequest.class_eval do
  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :member,
    is_parent: { permitted_children: [Comment, MembershipRequestResponse] }

  def custom_feeds
    [member.feed, group.feed]
  end
end