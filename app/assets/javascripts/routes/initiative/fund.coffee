CivicSourcing.InitiativeFundRoute = Ember.Route.extend(

  model: ->
    initiative = @modelFor('initiative')
    fund = initiative.get('fund')
    if fund?
      fund
    else
      @store.createRecord 'fund',
        initiative: initiative

  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    content = @get('controller.content')
    if content.get('isNew')
      content.rollback()

)