CivicSourcing.PetitionController = Ember.ObjectController.extend(
  CivicSourcing.PetitionSigningMixin

  userIsOfficer: (->
    membershipId = @get('initiative.membershipId')
    if membershipId
      @store.find('membership', membershipId).then((rec) ->
        rec.get('officer')
      )
  ).property('initiative.membershipId')
)