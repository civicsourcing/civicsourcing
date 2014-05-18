class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    can :authenticate, :all if !user.new_record?

    can :set_feature, :all if user.admin?

    # Comment
    can :manage, Comment do |comment|
      comment.user.id == user.id
    end

    # Community
    can :manage, Community do |community|
      community.has_officer?(user)
    end

    # CommunityCategory
    can :manage, CommunityCategory do |community_category|
      user.admin?
    end

    # Fund
    can :manage, Fund do |fund|
      fund.initiative.has_officer?(user)
    end

    # FundDonation
    can :manage, FundDonation do |fund_donation|
      fund_donation.user == user
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

    # Petition
    can :manage, Petition do |petition|
      petition.initiative.has_officer?(user)
    end

    # PetitionSignature
    can :manage, PetitionSignature do |petition_signature|
      petition_signature.user == user
    end

    # Post
    can :manage, Post do |post|
      post.user == user
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
