CivicSourcing.RegisterController = Ember.ObjectController.extend(
  CivicSourcing.FormMixin,
    transitionTo: 'confirm'
    dynamicSegment: false

  genders: [
    label: "Male"
    name: "male"
  ,
    label: "Female"
    name: "female"
  ]

)