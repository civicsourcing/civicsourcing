class FundDonationSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :amount

  has_one :fund, serializer: FundSerializer
  has_one :fund_reward, serializer: FundRewardSerializer
  has_one :user, serializer: UserSerializer

end
