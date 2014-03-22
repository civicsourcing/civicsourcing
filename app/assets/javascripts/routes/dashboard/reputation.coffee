CivicSourcing.DashboardReputationRoute = Ember.Route.extend(
  model: (params) ->
    @session.get('currentUser').then((user) ->
      user.get("badges")
    )
  setupController: (controller, model) ->
    controller.set('content', model)

)