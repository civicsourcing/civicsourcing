class Fund < ActiveRecord::Base
  include Feature
  
  attr_accessor :creator

  extend FriendlyId
  friendly_id :title, use: :history

  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :creator,
    is_parent: { permitted_children: [Comment] }
    
  belongs_to :initiative
  has_many :fund_rewards
  has_many :fund_donations

  validates :body, presence: true
  validates :end_date, presence: true,
    date: { after: Proc.new { Time.now + 7.days },
      before: Proc.new { Time.now + 60.days } }
  validates :goal, presence: true, numericality: { integer_only: true,
    greater_than_or_equal_to: 20 }
  validates :initiative, presence: true
  validates :stretch_goal, allow_blank: true,
    numericality: { integer_only: true }
  validates :title, presence: true

  validate :stretch_goal_acceptable_size

  accepts_nested_attributes_for :fund_rewards, allow_destroy: true

  def custom_feeds
    [creator.feed, initiative.feed]
  end

  def approve
    update_column(:admin_approved, true)
  end

  def succeed
    fund_donations.each { |donation| donation.pay }
    update_column(:active, false)
    FundMailer.funded(self).deliver
  end

  def fail
    update_column(:active, false)
    fund_donations.each { |donation| donation.underfunded }
    FundMailer.underfunded_manager(self).deliver
  end

  private
  def stretch_goal_acceptable_size
    unless stretch_goal.present? && stretch_goal > goal && stretch_goal <= goal * 2
      errors.add(:stretch_goal,
        "must be larger than goal but less than double the goal")
    end
  end
end
