CivicSourcing.DashboardController = Ember.ArrayController.extend(
  points: (->
    @get("session.currentUser.points")
  ).property("session.currentUser.points")

  communities: (->
    @get('model')
  ).property("model")

)