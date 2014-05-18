CivicSourcing.Petition = CivicSourcing.Amorphous.extend(

  user: DS.belongsTo "user"
  initiative: DS.belongsTo "initiative"

  petitionSignatureId: DS.attr()

  title: DS.attr()
  body: DS.attr()
  deliverTo: DS.attr()
  deliveryDate: DS.attr()
  goal: DS.attr()
  petitionSignaturesCount: DS.attr()
  slug: DS.attr()
  featured: DS.attr()
)