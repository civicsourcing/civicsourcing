class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    can :authenticate, :all if !user.new_record?

    # Users
    can :update, User do |edited_user|
      edited_user.id == user.id
    end
    
    can :create, User if user.new_record?

  end
end
