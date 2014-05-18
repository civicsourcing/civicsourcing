CivicSourcing.CommentEventView = Em.Component.extend

  layoutName: 'views/commentEvent'

  isEditing: false
  event: null
  user: (->
    @get("event.eventable.user")
  ).property("event.eventable.user")
  comment: (->
    @get("event.eventable")
  ).property("event")
  parentEvent: (->
    @get("comment.event.parent")
  ).property("comment")

  actions:

    deleteComment: ->
      comment = @get('comment')
      parent = @get('parentEvent')
      comment.deleteRecord()
      comment.save().then(((response) =>
        parent.reload()
      ),
      ((response) =>
        comment.rollback()
        @set("errors", response.errors)
      ))

    editComment: ->
      @set('isEditing', true)

    cancelEdit: ->
      @get('comment').rollback()
      @set('isEditing', false)

    submitComment: ->
      comment = @get('comment')
      comment.save().then(((response) =>
        @set('isEditing', false)
        @get('parentEvent').reload()
      ),
      ((response) =>
        @set("errors", response.errors)
      ))