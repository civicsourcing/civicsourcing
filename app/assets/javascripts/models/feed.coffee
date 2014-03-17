CivicSourcing.Feed = CivicSourcing.Amorphous.extend
  feedable: DS.belongsTo 'amorphous',
    polymorphic: true
  eventJoins: DS.hasMany 'event.join',
    async: true