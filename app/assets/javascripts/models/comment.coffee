CivicSourcing.Comment = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin

  parentEvent: DS.belongsTo "event",
    inverse: 'childEventable'

  body: DS.attr()
)