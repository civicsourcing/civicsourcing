CivicSourcing.GroupMembershipControllerMixin = Ember.Mixin.create(

  userIsOfficer: false

  setOfficer: (->
    membershipId = @get('membershipId')
    if membershipId
      @store.find('membership', membershipId).then((rec) =>
        @set('userIsOfficer', rec.get('officer'))
      )
  ).observes('membershipId')

  userIsMember: (->
    @get('membershipId')?
  ).property('membershipId')

  userHasRequestedMembership: (->
    @get('membershipRequestId')?
  ).property('membershipRequestId')

  userCanView: (->
    !@get("private") || @get('userIsMember')
  ).property('private', 'userIsMember')

  actions:
    leave: ->
      @store.find('membership', @get('membershipId')).then((rec) =>
        rec.deleteRecord()
        rec.save()
        @get('model').set('membershipId', null)
      )

    join: ->
      @get('session.currentUser').then( (user) =>
        @store.createRecord('membership',
          member: user
          group: @get('model')
        ).save().then((rec) =>
          @get('model').set('membershipId', rec.id)
        )
      )

    requestMembership: ->
      @get('session.currentUser').then( (user) =>
        @store.createRecord('membershipRequest',
          member: user
          group: @get('model')
        ).save().then((rec) =>
          @get('model').set('membershipRequestId', rec.id)
        )
      )

)