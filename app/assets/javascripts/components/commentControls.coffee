CivicSourcing.CommentControlsComponent = Em.Component.extend

  classNames: 'comment-controls'

  parentEvent: null
  currentSortMethod: null

  isCreatingComment: false
  newComment: null
  isExpanded: false

  sortAscending: (->
    @get("currentSortMethod.sortAscending")
  ).property("currentSortMethod.sortAscending")

  sortProperties: (->
    @get("currentSortMethod.sortProperties")
  ).property("currentSortMethod.sortProperties")

  expand: (->
    if @get("isTopLevel")
      @initializeComment()
    else
      @set("isExpanded", true)
  ).on('didInsertElement')

  isTopLevel: (->
    !@get("parentEvent.parent")?
  ).property('parentEvent.parent')

  initializeComment: ->
    newComment = @store.createRecord('comment',
      parentEvent: @get("parentEvent")
    )
    @set('newComment', newComment)
    @set('isCreatingComment', true)

  events: (->
    events = @get("parentEvent.children")
    Ember.ArrayProxy.createWithMixins(Ember.SortableMixin,
      sortAscending: @get("sortAscending")
      sortProperties: @get("sortProperties")
      content: events
    )
  ).property("parentEvent.children", "sortAscending", "sortProperties")

  errors: null

  actions:
    toggleComments: ->
      if @get("isExpanded")
        @set("isExpanded", false)
      else
        @set("isExpanded", true)

    createComment: ->
      @initializeComment()
      @set('isExpanded', true)

    cancelComment: ->
      @get('newComment').rollback()
      @set('newComment', null)
      @set('isCreatingComment', false)

    submitComment: ->
      newComment = @get('newComment')
      newComment.save().then(((response) =>
        @set('newComment', null)
        @set('isCreatingComment', false)
        @get('parentEvent').reload()
        if @get("isTopLevel")
          @initializeComment()
      ),
      ((response) =>
        @set("errors", response.errors)
      ))