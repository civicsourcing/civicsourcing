CivicSourcing.FeedForumComponent = Em.Component.extend(
  CivicSourcing.EventSortingMixin

  feed: null
  isCreatingPost: false
  newPost: null

  events: (->
    events = @get("feed.events")
    Ember.ArrayProxy.createWithMixins(Ember.SortableMixin,
      sortAscending: @get("sortAscending")
      sortProperties: @get("sortProperties")
      content: events
    )
  ).property("feed.events", "sortAscending", "sortProperties")

  actions:
    createPost: ->
      newPost = @store.createRecord('post',
        feed: @get("feed")
      )
      @set('newPost', newPost)
      @set('isCreatingPost', true)

    cancelPost: ->
      @get('newPost').rollback()
      @set('newPost', null)
      @set('isCreatingPost', false)

    submitPost: ->
      newPost = @get('newPost')
      newPost.save().then ((response) =>
        @set('newPost', null)
        @set('isCreatingPost', false)
        @get('feed').reload()
      )
)