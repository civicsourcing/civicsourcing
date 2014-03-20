CivicSourcing.MembershipRequestResponse = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin

  membershipRequest: DS.belongsTo "membershipRequest",
    inverse: "membershipRequestResponse"

  accepted: DS.attr()
  notes: DS.attr()
)