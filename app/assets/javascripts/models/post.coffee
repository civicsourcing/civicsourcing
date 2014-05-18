CivicSourcing.Post = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin
  
  user: DS.belongsTo "user"

  title: DS.attr()
  body: DS.attr()

  feed: DS.belongsTo "feed" # For form submissions
)