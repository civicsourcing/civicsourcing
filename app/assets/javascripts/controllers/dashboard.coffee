CivicSourcing.DashboardController = Ember.ObjectController.extend(
  points: (->
    @get("session.currentUser.points")
  ).property("session.currentUser.points")

  memberships: (->
    @store.findQuery 'membership',
      member_type: "User"
      member_id: @session.get('content.user_id')
      group_type: "Community"
  ).property("session.currentUser", "session.currentUser.memberships")

)