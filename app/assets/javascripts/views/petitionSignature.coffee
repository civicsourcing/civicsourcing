CivicSourcing.PetitionSignatureEventView = Em.Component.extend

  layoutName: 'views/petitionSignatureEvent'

  event: null
  petitionSignature: (->
    @get("event.eventable")
  ).property("event")