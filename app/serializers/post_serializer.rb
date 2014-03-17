class PostSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title, :body

  has_one :event, serializer: EventSerializer

end
