class MembershipRequestSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :created_at, :pending, :accepted, :declined

  has_one :group, polymorphic: true
  has_one :member, polymorphic: true
  has_one :event, serializer: EventSerializer
end
