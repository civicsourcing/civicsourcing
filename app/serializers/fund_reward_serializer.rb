class FundRewardSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :minimum_donation, :description, :limit, :fund_donations_count

  has_one :fund, serializer: FundSerializer

end
