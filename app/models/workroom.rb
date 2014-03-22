class Workroom < ActiveRecord::Base
  belongs_to :initiative
  has_many :tasks

  flexible_feeds
end
