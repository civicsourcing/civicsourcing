class EventJoinSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id

  has_one :event, serializer: EventSerializer
  has_one :feed, serializer: FeedSerializer

end
