class Community < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :history

  acts_as_group

  flexible_feeds

  belongs_to :upload

  has_many :initiatives

  validates :name, presence: true, length: { in: 3..80 }
  validates :slug, presence: true, uniqueness: { case_sensitive: false }
end
