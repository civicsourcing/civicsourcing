CivicSourcing.PostEventView = Em.Component.extend

  layoutName: 'views/postEvent'

  event: null
  post: (->
    @get("event.eventable")
  ).property("event")

  isExpanded: false

  actions:
    togglePost: ->
      if @get("isExpanded")
        @set("isExpanded", false)
      else
        @set("isExpanded", true)