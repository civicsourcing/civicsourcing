CivicSourcing.DashboardController = Ember.ObjectController.extend(
  points: (->
    @get("session.currentUser.points")
  ).property("session.currentUser.points")

)