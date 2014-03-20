CivicSourcing.Initiative = CivicSourcing.Amorphous.extend(
  CivicSourcing.GroupMixin

  community: DS.belongsTo "community"
  workroom: DS.belongsTo "workroom"

  description: DS.attr()
  name: DS.attr()
  slug: DS.attr()
)