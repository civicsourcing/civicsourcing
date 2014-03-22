CivicSourcing.MembershipRequest = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin

  member: DS.belongsTo 'amorphous',
    polymorphic: true
  group: DS.belongsTo 'amorphous',
    polymorphic: true
  membershipRequestResponse: DS.belongsTo "membershipRequestResponse",
    inverse: "membershipRequest"

  pending: DS.attr()
  accepted: DS.attr()
  declined: DS.attr()
)