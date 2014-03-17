CivicSourcing.CommentControlsComponent = Em.Component.extend

  classNames: 'comment-controls'

  parentEvent: null
  isCreatingComment: false
  newComment: null

  actions:
    createComment: ->
      newComment = @store.createRecord('comment',
        parentEvent: @get("parentEvent")
      )
      @set('newComment', newComment)
      @set('isCreatingComment', true)

    cancelComment: ->
      @get('newComment').rollback()
      @set('newComment', null)
      @set('isCreatingComment', false)

    submitComment: ->
      newComment = @get('newComment')
      newComment.save().then ((response) =>
        @set('newComment', null)
        @set('isCreatingComment', false)
        @get('parentEvent').reload()
      )