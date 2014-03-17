CivicSourcing.FeedForumComponent = Em.Component.extend

  feed: null
  isCreatingPost: false
  newPost: null

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