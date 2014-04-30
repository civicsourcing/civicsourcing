CivicSourcing.InitiativeController = Ember.ObjectController.extend(
  CivicSourcing.GroupMembershipControllerMixin

  tasks: (->
    @get("workroom.tasks")
  ).property("workroom.tasks")

  hasAPetition: (->
    @get("petition")?
  ).property("petition")

  actions:
    feature: ->
      jQuery.post "/api/v1/initiatives/#{ @get("id") }/features"
      , (r) =>
        if !r.errors
          if @get("featured")
            @set("featured", false)
          else
            @set("featured", true)

)