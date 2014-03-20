CivicSourcing.FeedEventComponent = Em.Component.extend

  event: null
  eventType: (->
    eventType = @get('event.eventable.constructor.typeKey')
    if eventType?
      eventType = eventType.capitalize()
      eval("CivicSourcing.#{eventType}EventView")
  ).property("event.eventable")