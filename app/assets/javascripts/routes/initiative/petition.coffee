CivicSourcing.InitiativePetitionRoute = Ember.Route.extend(

  model: ->
    initiative = @modelFor('initiative')
    petition = initiative.get('petition')
    if petition?
      petition
    else
      @store.createRecord 'petition',
        initiative: initiative

  setupController: (controller, model) ->
    controller.set('content', model)
  deactivate: ->
    content = @get('controller.content')
    if content.get('isNew')
      content.rollback()

)