CivicSourcing.VoteControlsComponent = Em.Component.extend

  tagName: 'section'
  classNames: 'vote-controls b ta-center pl-t pr-t'

  event: null

  currentUpvote: (->
    @get("event.voteFor") == 1
  ).property("event.voteFor")

  currentDownvote: (->
    @get("event.voteFor") == -1
  ).property("event.voteFor")

  createVote: (value) ->
    event = @get("event")
    @get("session.currentUser").then (user) =>
      vote = @store.createRecord('vote',
        event: event
        value: value
        voter: user
      ).save().then ( =>
        event.reload()
      )


  actions:
    upvote: ->
      @createVote(1)

    downvote: ->
      @createVote(-1)