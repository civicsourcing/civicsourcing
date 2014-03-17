CivicSourcing.Community = CivicSourcing.Amorphous.extend(
  CivicSourcing.FeedableMixin

  name: DS.attr()
  slug: DS.attr()
  private: DS.attr()
  
  completedInitiatives: DS.attr()
  membershipSize: DS.attr()

  upload: DS.belongsTo 'upload'

  membershipId: DS.attr()
)