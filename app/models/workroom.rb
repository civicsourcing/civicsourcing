class Workroom < ActiveRecord::Base
  belongs_to :initiative

  flexible_feeds
end
