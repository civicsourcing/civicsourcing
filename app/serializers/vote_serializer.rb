class VoteSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :value

  has_one :event, serializer: EventSerializer
  has_one :voter, polymorphic: true

end
