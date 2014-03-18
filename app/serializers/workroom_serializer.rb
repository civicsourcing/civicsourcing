class WorkroomSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id

  has_one :initiative, serializer: InitiativeSerializer
  has_one :feed, serializer: FeedSerializer

end
