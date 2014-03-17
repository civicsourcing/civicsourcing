class MembershipSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :created_at

  has_one :group, polymorphic: true
  has_one :member, polymorphic: true
end
