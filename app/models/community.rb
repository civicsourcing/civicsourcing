class Community < ActiveRecord::Base
  attr_accessor :creator

  extend FriendlyId
  friendly_id :name, use: :history

  acts_as_group

  flexible_feeds

  belongs_to :upload

  has_many :initiatives

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }

  after_create :create_creator_membership

  private
  def create_creator_membership
    add_officer(creator)
    creator.follow(feed)
  end
end
