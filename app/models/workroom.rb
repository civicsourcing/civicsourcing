class Workroom < ActiveRecord::Base
  belongs_to :initiative
  has_many :tasks

  flexible_feeds

  def community
    initiative.community
  end
end
