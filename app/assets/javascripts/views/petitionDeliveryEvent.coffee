CivicSourcing.PetitionDeliveryEventView = Em.Component.extend

  layoutName: 'views/petitionDeliveryEvent'

  event: null
  petitionDelivery: (->
    @get("event.eventable")
  ).property("event")