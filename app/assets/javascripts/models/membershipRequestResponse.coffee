CivicSourcing.MembershipRequestResponse = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin

  user: DS.belongsTo "user"
  membershipRequest: DS.belongsTo "membershipRequest",
    inverse: "membershipRequestResponse"

  accepted: DS.attr()
  notes: DS.attr()
)