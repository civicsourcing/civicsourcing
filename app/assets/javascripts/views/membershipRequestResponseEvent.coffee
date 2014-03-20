CivicSourcing.MembershipRequestResponseEventView = Em.Component.extend

  layoutName: 'views/membershipRequestResponseEvent'

  event: null
  membershipRequestResponse: (->
    @get("event.eventable")
  ).property("event")

  acceptance: (->
    if @get("membershipRequestResponse.accepted")
      "accepted"
    else
      "declined"
  ).property("membershipRequestResponse.accepted")