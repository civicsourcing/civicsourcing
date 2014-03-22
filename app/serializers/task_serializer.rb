class TaskSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :completed, :name

  has_one :event, serializer: EventSerializer
  has_one :workroom, serializer: WorkroomSerializer

end
