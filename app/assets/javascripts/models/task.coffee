CivicSourcing.Task = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin
  
  user: DS.belongsTo "user"
  workroom: DS.belongsTo 'workroom'
  name: DS.attr()
  completed: DS.attr()
)