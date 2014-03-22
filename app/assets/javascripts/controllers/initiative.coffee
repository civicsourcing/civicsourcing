CivicSourcing.InitiativeController = Ember.ObjectController.extend(
  CivicSourcing.GroupMembershipControllerMixin

  tasks: (->
    @get("workroom.tasks")
  ).property("workroom.tasks")
)