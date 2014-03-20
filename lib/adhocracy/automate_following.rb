require_dependency FlexibleFeeds::Engine.root.join('app', 'models', 'flexible_feeds', 'feed').to_s
require_dependency Adhocracy::Engine.root.join('app', 'models', 'adhocracy', 'membership').to_s

Adhocracy::Membership.class_eval do
  
  after_create :follow_group
  after_destroy :unfollow_group

  private
  def follow_group
    member.follow(group.feed)
  end

  def unfollow_group
    member.unfollow(group.feed)
  end
end