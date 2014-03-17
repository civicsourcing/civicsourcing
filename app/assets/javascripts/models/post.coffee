CivicSourcing.Post = CivicSourcing.Amorphous.extend(
  CivicSourcing.EventableMixin

  title: DS.attr()
  body: DS.attr()

  feed: DS.belongsTo "feed" # For form submissions
)