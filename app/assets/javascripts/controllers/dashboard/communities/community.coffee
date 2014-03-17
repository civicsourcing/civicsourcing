CivicSourcing.DashboardCommunitiesCommunityController = Ember.ObjectController.extend(
  
  uploadUrl: (->
    @get('upload.file.url')
  ).property('upload')

  userIsMember: (->
    @get('membershipId')?
  ).property('membershipId')

  userMembership: (->
    @get('store').find('membership', @get('membershipId'))
  ).property('membershipId')

  actions:
    leave: ->
      @get('userMembership').then((rec) =>
        rec.deleteRecord()
        rec.save()
        @get('model').set('membershipId', null)
      )

    join: ->
      @get('session.currentUser').then( (user) =>
        membership = @get('store').createRecord('membership',
          member: user
          group: @get('model')
        )
        membership.save().then((rec) =>
          @get('model').set('membershipId', rec.id)
        )
      )
)