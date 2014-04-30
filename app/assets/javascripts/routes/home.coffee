CivicSourcing.HomeRoute = Ember.Route.extend(
  model: (params) ->
    return Em.RSVP.hash
      leaders: @store.findQuery 'community',
        order: "score DESC"
        limit: 10
      initiative: @store.findQuery 'initiative',
        featured: true
      petition: @store.findQuery 'petition',
        featured: true

  setupController: (controller, model) ->
    controller.setProperties(model)
)