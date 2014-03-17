CivicSourcing.DashboardCommunitiesNewRoute = Ember.Route.extend(

  model: ->
    @store.createRecord('community')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)