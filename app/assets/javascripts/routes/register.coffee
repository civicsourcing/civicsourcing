CivicSourcing.RegisterRoute = Ember.Route.extend(

  model: ->
    @store.createRecord('user')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)