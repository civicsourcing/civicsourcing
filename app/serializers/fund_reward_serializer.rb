class FundRewardSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :minimum_donation, :description, :limit, :fund_donation_count

  has_one :fund, serializer: FundSerializer

end
