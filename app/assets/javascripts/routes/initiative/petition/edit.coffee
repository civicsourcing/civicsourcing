CivicSourcing.InitiativePetitionEditRoute = Ember.Route.extend(

  model: ->
    @modelFor('initiative.petition')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)