CivicSourcing.Fund = CivicSourcing.Amorphous.extend(

  user: DS.belongsTo "user"
  initiative: DS.belongsTo "initiative"
  fundRewards: DS.hasMany "fundReward",
    async: true
  fundDonations: DS.hasMany "fundDonation"

  fundDonationId: DS.attr()

  active: DS.attr()
  goal: DS.attr()
  stretchGoal: DS.attr()
  endDate: DS.attr()
  body: DS.attr()
  title: DS.attr()
  totalDonations: DS.attr()
  slug: DS.attr()
  featured: DS.attr()
)