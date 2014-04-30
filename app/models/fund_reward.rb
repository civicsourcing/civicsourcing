class FundReward < ActiveRecord::Base
  belongs_to :fund
  has_many :fund_donations

  validates :minimum_donation, numericality: { integer_only: true,
    greater_than_or_equal_to: 5 }
  validates :description, presence: true
  validates :limit, allow_blank: true, numericality: { integer_only: true,
    greater_than_or_equal_to: 1 }
end
