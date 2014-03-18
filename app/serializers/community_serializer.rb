class CommunitySerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name, :slug, :membership_size, :completed_initiatives,
    :membership_id, :private

  has_one :upload, serializer: UploadSerializer
  has_one :feed, serializer: FeedSerializer

  has_many :initiatives, serializer: InitiativeSerializer

  def membership_id
    scope.memberships.where(group: object).pluck(:id).first
  end

  def membership_size
    object.memberships.size
  end
end
