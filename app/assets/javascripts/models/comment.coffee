CivicSourcing.Comment = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin

  user: DS.belongsTo "user",
    async: true
  parentEvent: DS.belongsTo "event",
    inverse: 'childEventable'

  canBeEdited: DS.attr()

  body: DS.attr()
)