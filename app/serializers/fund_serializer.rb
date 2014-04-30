class FundSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :active, :goal, :stretch_goal, :end_date, :body, :title,
    :total_donations, :fund_donation_id, :slug, :featured

  has_one :initiative, serializer: InitiativeSerializer
  has_many :fund_rewards, serializer: FundRewardSerializer

  def fund_donation_id
    FundDonation.find_by(user: scope, fund: object).try(:id)
  end

end
