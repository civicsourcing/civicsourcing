CivicSourcing.FeedEventComponent = Em.Component.extend

  event: null
  eventType: (->
    switch @get('event.eventable.constructor.typeKey')
      when "post" then CivicSourcing.PostEventView
      when "comment" then CivicSourcing.CommentEventView
  ).property("event.eventable")