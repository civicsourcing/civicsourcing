class InitiativeSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :slug, :description, :membership_id,
    :membership_request_id, :featured

  has_one :user, serializer: UserSerializer
  has_one :upload, serializer: UploadSerializer
  has_one :community, serializer: CommunitySerializer
  has_one :workroom, serializer: WorkroomSerializer
  has_one :petition, serializer: PetitionSerializer
  has_one :fund, serializer: FundSerializer

  def membership_id
    scope.memberships.where(group: object).pluck(:id).first if scope
  end

  def membership_request_id
    Adhocracy::MembershipRequest.where(member: scope, group: object,
      pending: true).pluck(:id).first
  end
end
