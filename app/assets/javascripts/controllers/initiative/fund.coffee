CivicSourcing.InitiativeFundController = Ember.ObjectController.extend(

  actions:
    submit: (event, view) ->
      @get('model').save().then(((response) =>
        @get('model.initiative').reload()
      ),
      ((response) ->
        console.log(response.errors)
      ))

    addReward: ->
      reward = @store.createRecord('fundReward')
      @get('fundRewards').pushObject(reward)

    removeReward: (reward) ->
      reward.set "_destroy", true
)