class CommentSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :body, :can_be_edited

  has_one :user, serializer: UserSerializer
  has_one :event, serializer: EventSerializer

  def can_be_edited
    !event.children.present? && scope.id == object.user.id
  end

end
