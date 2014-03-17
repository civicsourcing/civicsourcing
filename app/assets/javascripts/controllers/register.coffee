CivicSourcing.RegisterController = Ember.ObjectController.extend(
  CivicSourcing.FormMixin,
    transitionTo: 'dashboard.feed'
    dynamicSegment: false

)