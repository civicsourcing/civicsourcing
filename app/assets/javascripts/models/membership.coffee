CivicSourcing.Membership = DS.Model.extend
  member: DS.belongsTo 'amorphous',
    polymorphic: true
  group: DS.belongsTo 'amorphous',
    polymorphic: true

  createdAt: DS.attr()