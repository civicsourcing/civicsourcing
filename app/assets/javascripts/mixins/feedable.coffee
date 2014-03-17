CivicSourcing.FeedableMixin = Ember.Mixin.create(

  feed: DS.belongsTo "feed",
    inverse: "feedable"

)