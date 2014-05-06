class Petition < ActiveRecord::Base
  include Feature
  
  attr_accessor :creator

  extend FriendlyId
  friendly_id :title, use: :history

  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }

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

  scope :undelivered, -> { where(delivered: false) }

  def self.deliver_petitions
    Petition.undelivered.each do |petition|
      petition.deliver if DateTime.now > petition.delivery_date
    end
  end

  def custom_feeds
    [creator.feed, initiative.feed]
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
end
