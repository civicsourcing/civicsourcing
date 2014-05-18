class Petition < ActiveRecord::Base
  include Feature

  extend FriendlyId
  friendly_id :title, use: :history

  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :user
  belongs_to :initiative
  has_one :petition_delivery
  has_many :petition_signatures

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :title, presence: true
  validates :body, presence: true
  validates :deliver_to, presence: true, format: { with: VALID_EMAIL_REGEX}
  validates :initiative, presence: true
  validates :goal, allow_blank: true, numericality: { only_integer: true,
    greater_than_or_equal_to: 5 }
  validates :delivery_date, allow_blank: true,
    date: { after: Proc.new { Time.now + 2.weeks },
      before: Proc.new { Time.now + 1.year } }

  validate :has_an_end_condition

  after_save :check_if_goal_is_met
  after_create :add_points
  after_destroy :subtract_points

  scope :undelivered, -> { where(delivered: false) }

  def community
    initiative.community
  end

  def self.deliver_petitions
    Petition.undelivered.each do |petition|
      petition.deliver if DateTime.now > petition.delivery_date
    end
  end

  def custom_feeds
    [user.feed, initiative.feed]
  end

  def deliver
    MiscMailer.deliver_petition(self).deliver
    update_column(:delivered, true)
    create_petition_delivery
  end

  private
  def has_an_end_condition
    unless goal.present? || delivery_date.present?
      errors[:base] << "Must provide either a signature goal or delivery date."
    end
  end

  def check_if_goal_is_met
    deliver if !delivered? && goal.present? && petition_signatures_count >= goal
  end

  def add_points
    user.add_points(20, category: 'Petition')
    community.add_points(20)
  end

  def subtract_points
    user.subtract_points(20, category: 'Petition')
    community.subtract_points(20)
  end
end
