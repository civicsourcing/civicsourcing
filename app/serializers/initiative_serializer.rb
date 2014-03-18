class InitiativeSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :slug, :description, :membership_id

  has_one :community, serializer: CommunitySerializer
  has_one :workroom, serializer: WorkroomSerializer

  def membership_id
    scope.memberships.where(group: object).pluck(:id).first
  end
end
