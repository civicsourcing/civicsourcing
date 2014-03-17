class EventSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :children_count, :votes_sum, :votes_for, :votes_against,
    :controversy, :popularity, :vote_for

  has_many :children, serializer: EventSerializer
  has_many :event_joins, serializer: EventJoinSerializer
  has_one :eventable, polymorphic: true
  has_one :creator, polymorphic: true
  has_one :parent, polymorphic: true
  has_one :ancestor, polymorphic: true

  def vote_for
    FlexibleFeeds::Vote.find_by(voter: scope, event: object).try(:value)
  end

end
