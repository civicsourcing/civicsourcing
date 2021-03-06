CivicSourcing.Event = CivicSourcing.Amorphous.extend
  eventable: DS.belongsTo 'amorphous',
    polymorphic: true, inverse: 'parentEvent'
  childEventable: DS.hasMany 'amorphous',
    polymorphic: true
  aggregator: DS.belongsTo 'user',
    inverse: 'aggregateFollows'

  feeds: DS.hasMany 'feed',
    inverse: 'events', async: true

  ancestor: DS.belongsTo 'event',
    inverse: 'descendants'
  descendants: DS.belongsTo 'event',
    inverse: 'ancestor', async: true
  parent: DS.belongsTo 'event',
    inverse: 'children'
  children: DS.hasMany 'event',
    inverse: 'parent', async: true

  voteFor: DS.attr()

  votesSum: DS.attr()
  votesFor: DS.attr()
  votesAgainst: DS.attr()
  controversy: DS.attr()
  popularity: DS.attr()
  updatedAt: DS.attr()
  childrenCount: DS.attr()