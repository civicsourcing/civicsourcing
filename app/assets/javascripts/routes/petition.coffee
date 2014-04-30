CivicSourcing.PetitionRoute = Ember.Route.extend(

  serialize: (model) ->
    petition_id: model.get('slug')
)