CivicSourcing.InitiativeController = Ember.ObjectController.extend(
  CivicSourcing.GroupMembershipControllerMixin

  tasks: (->
    @get("workroom.tasks")
  ).property("workroom.tasks")

  hasAPetition: (->
    @get("petition")?
  ).property("petition")
)