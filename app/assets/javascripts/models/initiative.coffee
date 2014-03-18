CivicSourcing.Initiative = DS.Model.extend(
  community: DS.belongsTo "community"
  workroom: DS.belongsTo "workroom"

  description: DS.attr()
  name: DS.attr()
  slug: DS.attr()

  membershipId: DS.attr()
)