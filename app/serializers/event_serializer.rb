class EventSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :children_count, :votes_sum, :votes_for, :votes_against,
    :controversy, :popularity, :vote_for, :updated_at

  has_many :children, serializer: EventSerializer
  has_many :feeds, serializer: FeedSerializer
  has_one :eventable, polymorphic: true
  has_one :creator, polymorphic: true
  has_one :parent, serializer: EventSerializer
  has_one :ancestor, serializer: EventSerializer

  def vote_for
    FlexibleFeeds::Vote.find_by(voter: scope, event: object).try(:value)
  end

end
