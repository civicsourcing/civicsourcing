CivicSourcing.Event = CivicSourcing.Amorphous.extend
  creator: DS.belongsTo 'amorphous',
    polymorphic: true
  eventable: DS.belongsTo 'amorphous',
    polymorphic: true, inverse: 'parentEvent'
  childEventable: DS.hasMany 'amorphous',
    polymorphic: true
  eventJoins: DS.hasMany 'event.join',
    async: true

  ancestor: DS.belongsTo 'event',
    inverse: 'descendants'
  descendants: DS.belongsTo 'event',
    inverse: 'ancestor'
  parent: DS.belongsTo 'event',
    inverse: 'children'
  children: DS.hasMany 'event',
    inverse: 'parent'

  voteFor: DS.attr()

  votesSum: DS.attr()
  votesFor: DS.attr()
  votesAgainst: DS.attr()
  controversy: DS.attr()
  popularity: DS.attr()