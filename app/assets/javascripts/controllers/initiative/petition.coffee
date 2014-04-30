CivicSourcing.InitiativePetitionController = Ember.ObjectController.extend(
  CivicSourcing.PetitionSigningMixin

  actions:

    submit: (event, view) ->
      @get('model').save().then(((response) =>
        @get('model.initiative').reload()
      ),
      ((response) ->
        console.log(response.errors)
      ))
)