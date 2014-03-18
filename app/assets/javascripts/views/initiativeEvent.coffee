CivicSourcing.InitiativeEventView = Em.Component.extend

  layoutName: 'views/initiativeEvent'

  event: null
  initiative: (->
    @get("event.eventable")
  ).property("event")