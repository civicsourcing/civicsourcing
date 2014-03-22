CivicSourcing.Workroom = DS.Model.extend(
  CivicSourcing.FeedableMixin

  initiative: DS.belongsTo "initiative"

  tasks: DS.hasMany 'task'
)