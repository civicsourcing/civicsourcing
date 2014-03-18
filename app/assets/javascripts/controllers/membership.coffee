CivicSourcing.MembershipController = Ember.ObjectController.extend(
  
  membershipSizeMinusUser: (->
    @get("group.membershipSize") - 1
  ).property("group.membershipSize")
        
)