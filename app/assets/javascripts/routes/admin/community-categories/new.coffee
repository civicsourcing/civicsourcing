CivicSourcing.AdminCommunityCategoriesNewRoute = Ember.Route.extend(

  model: ->
    @store.createRecord('communityCategory')
  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    @get('controller.content').rollback()

)