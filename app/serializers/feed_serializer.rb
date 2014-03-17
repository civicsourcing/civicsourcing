class FeedSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id

  has_many :events, serializer: EventSerializer

end
