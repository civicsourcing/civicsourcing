CivicSourcing.Initiative = CivicSourcing.Amorphous.extend(
  CivicSourcing.GroupMixin

  community: DS.belongsTo "community"
  fund: DS.belongsTo "fund"
  petition: DS.belongsTo "petition"
  workroom: DS.belongsTo "workroom"

  description: DS.attr()
  name: DS.attr()
  slug: DS.attr()
)