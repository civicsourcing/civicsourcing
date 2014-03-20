CivicSourcing.MembershipRequestResponseControlsComponent = Em.Component.extend

  membershipRequest: null

  createResponse: (accepted) ->
    membershipRequest = @get("membershipRequest")
    response = @store.createRecord('membershipRequestResponse',
      membershipRequest: membershipRequest
      accepted: accepted
    ).save().then ->
      membershipRequest.reload()
      membershipRequest.get("event").reload()

  actions:
    acceptMembership: ->
      @createResponse(true)

    declineMembership: ->
      @createResponse(false)