CivicSourcing.InitiativePetitionController = Ember.ObjectController.extend(
  CivicSourcing.PetitionSigningMixin

  userIsOfficer: (->
    membershipId = @get('initiative.membershipId')
    if membershipId
      @store.find('membership', membershipId).then((rec) ->
        rec.get('officer')
      )
  ).property('initiative.membershipId')

  actions:

    submit: (event, view) ->
      @get('model').save().then(((response) =>
        @get('model.initiative').reload()
      ),
      ((response) ->
        console.log(response.errors)
      ))
)