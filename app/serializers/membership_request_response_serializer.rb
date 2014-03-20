class MembershipRequestResponseSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :accepted, :notes

  has_one :membership_request, serializer: "MembershipRequestSerializer"
  has_one :event, serializer: EventSerializer
end
