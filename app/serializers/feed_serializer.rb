class FeedSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id

  has_many :event_joins, serializer: EventJoinSerializer

end
