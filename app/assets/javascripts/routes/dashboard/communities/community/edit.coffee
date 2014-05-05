CivicSourcing.DashboardCommunitiesCommunityEditRoute = Ember.Route.extend(

  model: ->
    @modelFor('dashboard.communities.community')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)