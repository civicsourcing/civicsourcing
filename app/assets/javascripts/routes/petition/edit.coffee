CivicSourcing.PetitionEditRoute = Ember.Route.extend(

  model: ->
    @modelFor('petition')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)