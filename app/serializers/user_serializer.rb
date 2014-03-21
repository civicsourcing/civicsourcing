class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :username, :slug, :points

  has_one :upload
  has_many :aggregate_follows, serializer: EventSerializer
end
