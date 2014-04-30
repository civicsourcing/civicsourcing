CivicSourcing.HomeController = Ember.Controller.extend(
  featuredInitiative: (->
    @get('initiative.content')[0]
  ).property("initiative")

  featuredPetition: (->
    @get('petition.content')[0]
  ).property("petition")
)