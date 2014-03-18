CivicSourcing.RegisterController = Ember.ObjectController.extend(
  CivicSourcing.FormMixin,
    transitionTo: 'dashboard.feed'
    dynamicSegment: false

  genders: [
    label: "Male"
    name: "male"
  ,
    label: "Female"
    name: "female"
  ]

)