class InitiativeSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :slug, :description, :membership_id,
    :membership_request_id

  has_one :community, serializer: CommunitySerializer
  has_one :workroom, serializer: WorkroomSerializer

  def membership_id
    scope.memberships.where(group: object).pluck(:id).first
  end

  def membership_request_id
    Adhocracy::MembershipRequest.where(member: scope, group: object,
      pending: true).pluck(:id).first
  end
end
