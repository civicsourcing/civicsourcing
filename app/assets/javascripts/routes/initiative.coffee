CivicSourcing.InitiativeRoute = Ember.Route.extend(

  serialize: (model) ->
    initiative_id: model.get('slug')
)