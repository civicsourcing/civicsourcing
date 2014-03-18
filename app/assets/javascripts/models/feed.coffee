CivicSourcing.Feed = CivicSourcing.Amorphous.extend
  feedable: DS.belongsTo 'amorphous',
    polymorphic: true

  events: DS.hasMany 'event',
    inverse: 'feeds'