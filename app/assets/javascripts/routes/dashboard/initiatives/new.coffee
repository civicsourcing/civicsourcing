CivicSourcing.DashboardInitiativesNewRoute = Ember.Route.extend(

  model: ->
    @store.createRecord('initiative')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)