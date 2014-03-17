CivicSourcing.FeedForumComponent = Em.Component.extend

  feed: null
  isCreatingPost: false
  newPost: null
  currentSortMethod: null
  sortAscending: null
  sortProperties: null

  sortMethods: [
    name: "New"
    id: 'new'
    sortAscending: false
    sortProperties: ["updatedAt"]
  ,
    name: "Hot"
    id: 'hot'
    sortAscending: false
    sortProperties: ["childrenCount"]
  ,
    name: "Popular"
    id: "popular"
    sortAscending: false
    sortProperties: ["popularity"]
  ,
    name: "Controversial"
    id: "controversial"
    sortAscending: false
    sortProperties: ["controversy"]
  ]

  sortMethodObserver: (->
    @set("sortAscending", @get("currentSortMethod.sortAscending"))
    @set("sortProperties", @get("currentSortMethod.sortProperties"))
  ).observes("currentSortMethod")

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