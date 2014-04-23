CivicSourcing.PetitionSignature = CivicSourcing.Amorphous.extend(

  petition: DS.belongsTo "petition"
  user: DS.belongsTo "user"

  comment: DS.attr()
)