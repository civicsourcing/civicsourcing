CivicSourcing.FundReward = CivicSourcing.Amorphous.extend(

  fund: DS.belongsTo "fund"

  minimumDonation: DS.attr()
  description: DS.attr()
  limit: DS.attr()
  fundDonationsCount: DS.attr()
  _destroy: DS.attr()

  label: (->
    description = @get('description')
    limit = @get('limit')
    fundDonationsCount = @get('fundDonationsCount')
    description += "(#{fundDonationsCount} of #{limit} taken)" if limit?
    description
  ).property('description', 'limit', 'fundDonationsCount')
)