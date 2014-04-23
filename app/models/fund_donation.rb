class FundDonation < ActiveRecord::Base

  acts_as_eventable add_to_feeds: :custom_feeds, created_by: :user,
    is_parent: { permitted_children: [Comment] }

  belongs_to :fund
  belongs_to :fund_reward, counter_cache: true
  belongs_to :user

  validates :fund, presence: true
  validates :user, presence: true
  validates :amount, presence: true, numericality: { integer_only: true,
    greater_than_or_equal_to: 1 }
  validates :user, presence: true, uniqueness: { scope: :fund_id }

  validate :amount_equals_or_exceeds_reward_minimum
  validate :reward_is_available

  def custom_feeds
    [user.feed, fund.initiative.feed]
  end
    
  private
  def amount_equals_or_exceeds_reward_minimum
    unless amount >= fund_reward.minimum_donation
      errors.add(:amount,
        "must equal or exceed reward minimum of $#{ fund_reward.minimum_donation }.00")
    end
  end

  def reward_is_available
    unless reward.limit > reward.fundDonationCount && (this.new_record? || this.changes.includes?("fund_reward_id"))
      errors.add(:amount,
        "must equal or exceed reward minimum of $#{ fund_reward.minimum_donation }.00")
    end
  end
end
