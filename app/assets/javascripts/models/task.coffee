CivicSourcing.Task = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin
  
  workroom: DS.belongsTo 'workroom'
  name: DS.attr()
  completed: DS.attr()
)