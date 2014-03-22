class CommunityCategorySerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :name

  has_many :communities, serializer: CommunitySerializer
end
