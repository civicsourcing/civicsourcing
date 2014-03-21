CivicSourcing.CommunityEventView = Em.Component.extend

  layoutName: 'views/communityEvent'

  event: null
  community: (->
    @get("event.eventable")
  ).property("event")