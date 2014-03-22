CivicSourcing.InitiativeTaskController = Ember.ObjectController.extend(

  CivicSourcing.FormMixin,
    transitionTo: 'initiative.feed'
    dynamicSegment: false
        
)