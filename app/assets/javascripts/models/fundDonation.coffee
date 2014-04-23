CivicSourcing.FundDonation = CivicSourcing.Amorphous.extend(

  fund: DS.belongsTo "fund"
  fundReward: DS.belongsTo "fundReward"
  user: DS.belongsTo "user"

  amount: DS.attr()
)