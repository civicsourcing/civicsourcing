CivicSourcing.PetitionEventView = Em.Component.extend

  layoutName: 'views/petitionEvent'

  event: null
  petition: (->
    @get("event.eventable")
  ).property("event")