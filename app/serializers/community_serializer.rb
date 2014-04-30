class CommunitySerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :slug, :membership_size, :completed_initiatives,
    :membership_id, :membership_request_id, :private, :overall_rank,
    :category_rank

  has_one :upload, serializer: UploadSerializer
  has_one :feed, serializer: FeedSerializer
  has_one :community_category, serializer: CommunityCategorySerializer

  has_many :initiatives, serializer: InitiativeSerializer

  def membership_size
    object.memberships.size
  end

  def membership_id
    scope.memberships.where(group: object).pluck(:id).first if scope.present?
  end

  def membership_request_id
    Adhocracy::MembershipRequest.where(member: scope, group: object,
      pending: true).pluck(:id).first
  end
end
