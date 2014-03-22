class UserSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :username, :slug, :points, :gender

  has_one :upload
  has_many :aggregate_follows, serializer: EventSerializer
  has_many :badges, serializer: BadgeSerializer
end
