CivicSourcing.DashboardFeedRoute = Ember.Route.extend(
  model: (params) ->
    @session.get('currentUser').then((user) ->
      user.get("aggregateFollows")
    )
  setupController: (controller, model) ->
    controller.set('content', model)

)