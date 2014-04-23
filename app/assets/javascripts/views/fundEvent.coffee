CivicSourcing.FundEventView = Em.Component.extend

  layoutName: 'views/fundEvent'

  event: null
  fund: (->
    @get("event.eventable")
  ).property("event")