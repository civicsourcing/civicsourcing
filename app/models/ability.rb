class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    can :authenticate, :all if !user.new_record?

    # Comment
    can :manage, Comment do |comment|
      comment.event.creator == user
    end

    # Community
    can :manage, Community do |community|
      community.has_officer?(user)
    end

    # CommunityCategory
    can :manage, CommunityCategory do |community_category|
      user.admin?
    end

    # Initiative
    can :manage, Initiative do |initiative|
      initiative.has_officer?(user)
    end

    # Membership
    can :manage, Adhocracy::Membership do |membership|
      membership.member == user
    end

    # MembershipRequest
    can :manage, Adhocracy::MembershipRequest do |request|
      request.member == user
    end

    # MembershipRequestResponse
    can :create, MembershipRequestResponse do |response|
      response.membership_request.group.has_officer?(user)
    end

    # Post
    can :manage, Post do |post|
      post.event.creator == user
    end

    # Task
    can :manage, Task do |task|
      task.workroom.initiative.has_officer?(user)
    end

    # User
    can :update, User do |edited_user|
      edited_user.id == user.id
    end
    
    can :create, User if user.new_record?

  end
end
