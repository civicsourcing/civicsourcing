class FundDonation < ActiveRecord::Base

  acts_as_eventable add_to_feeds: :custom_feeds,
    is_parent: { permitted_children: [Comment] }

  belongs_to :fund
  belongs_to :fund_reward, counter_cache: true
  belongs_to :user

  validates :fund, presence: true
  validates :user, presence: true
  validates :amount, presence: true, numericality: { integer_only: true,
    greater_than_or_equal_to: 5 }
  validates :user, presence: true, uniqueness: { scope: :fund_id }

  validate :amount_equals_or_exceeds_reward_minimum
  validate :reward_is_available

  def custom_feeds
    [user.feed, fund.initiative.feed]
  end

  def pay
    OrderFulfiller.new(self).pay
  end

  def underfunded
    FundMailer.underfunded_donor(self).deliver
  end
    
  private
  def amount_equals_or_exceeds_reward_minimum
    if fund_reward.present?
      unless amount >= fund_reward.minimum_donation
        errors.add(:amount,
          "must equal or exceed reward minimum of $#{ fund_reward.minimum_donation }.00")
      end
    end
  end

  def reward_is_available
    if fund_reward.present? && fund_reward.limit.present?
      unless fund_reward.limit > fund_reward.fund_donations_count &&
        (this.new_record? || this.changes.includes?("fund_reward_id"))
          errors.add(:amount,
            "must equal or exceed reward minimum of $#{ fund_reward.minimum_donation }.00")
      end
    end
  end
end
