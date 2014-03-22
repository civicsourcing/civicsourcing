CivicSourcing.TaskEventView = Em.Component.extend

  layoutName: 'views/taskEvent'

  event: null
  task: (->
    @get("event.eventable")
  ).property("event")