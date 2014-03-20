CivicSourcing.MembershipRequestEventView = Em.Component.extend

  layoutName: 'views/membershipRequestEvent'

  event: null
  membershipRequest: (->
    @get("event.eventable")
  ).property("event")

  createResponse: (accepted) ->
    membershipRequest = @get("membershipRequest")
    @store.createRecord('membershipRequestResponse',
      membershipRequest: membershipRequest
      accepted: accepted
    ).save().then ->
      membershipRequest.reload()

  actions:
    acceptMembership: ->
      @createResponse(true)

    declineMembership: ->
      @createResponse(false)