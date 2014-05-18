CivicSourcing.DashboardRoute = Ember.Route.extend(
  Ember.SimpleAuth.AuthenticatedRouteMixin

  model: (params) ->
    @store.findQuery 'community',
      order: "score DESC"
      limit: 10
)