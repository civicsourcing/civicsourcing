CivicSourcing.CommentEventView = Em.Component.extend

  layoutName: 'views/commentEvent'

  event: null
  comment: (->
    @get("event.eventable")
  ).property("event")