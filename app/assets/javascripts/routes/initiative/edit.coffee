CivicSourcing.InitiativeEditRoute = Ember.Route.extend(

  model: ->
    @modelFor('initiative')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)