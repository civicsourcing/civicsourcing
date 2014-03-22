CivicSourcing.Badge = CivicSourcing.Amorphous.extend(
  user: DS.belongsTo "user"

  name: DS.attr()
  description: DS.attr()
  points: DS.attr()
)