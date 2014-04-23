CivicSourcing.FundReward = CivicSourcing.Amorphous.extend(

  fund: DS.belongsTo "fund"

  minimumDonation: DS.attr()
  description: DS.attr()
  limit: DS.attr()
  fundDonationCount: DS.attr()
  _destroy: DS.attr()

  label: (->
    description = @get('description')
    limit = @get('limit')
    fundDonationCount = @get('fundDonationCount')
    description += "(#{fundDonationCount} of #{limit} taken)" if limit?
    description
  ).property('description', 'limit', 'fundDonationCount')
)