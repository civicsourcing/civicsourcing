CivicSourcing.FormMixin = Ember.Mixin.create(

  dynamicSegment: true

  actions:
    submit: (event, view) ->
      @get('model').save().then(((response) =>
        if @get("dynamicSegment")
          @transitionToRoute(@get("transitionTo"), @content)
        else
          @transitionToRoute(@get("transitionTo"))
      ),
      ((response) ->
        console.log(response.errors)
      ))


)