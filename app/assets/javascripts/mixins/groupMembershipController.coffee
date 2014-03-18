CivicSourcing.GroupMembershipControllerMixin = Ember.Mixin.create(

  userIsMember: (->
    @get('membershipId')?
  ).property('membershipId')

  actions:
    leave: ->
      @store.find('membership', @get('membershipId')).then((rec) =>
        rec.deleteRecord()
        rec.save()
        @get('model').set('membershipId', null)
      )

    join: ->
      @get('session.currentUser').then( (user) =>
        membership = @store.createRecord('membership',
          member: user
          group: @get('model')
        )
        membership.save().then((rec) =>
          @get('model').set('membershipId', rec.id)
        )
      )

)