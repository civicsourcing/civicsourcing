class PostSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :title, :body

  has_one :user, serializer: UserSerializer
  has_one :event, serializer: EventSerializer

end
