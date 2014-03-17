class CommentSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :body

  has_one :event, serializer: EventSerializer

end
