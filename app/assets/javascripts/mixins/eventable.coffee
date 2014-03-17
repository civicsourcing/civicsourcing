CivicSourcing.EventableMixin = Ember.Mixin.create(

  event: DS.belongsTo "event",
    inverse: "eventable"

)