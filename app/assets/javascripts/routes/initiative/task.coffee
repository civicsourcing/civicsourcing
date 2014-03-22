CivicSourcing.InitiativeTaskRoute = Ember.Route.extend(

  model: ->
    @store.createRecord('task',
      workroom: @modelFor('initiative').get('workroom')
    )
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)