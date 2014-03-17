CivicSourcing.User = CivicSourcing.Amorphous.extend(
  CivicSourcing.FeedableMixin

  username: DS.attr()
  email: DS.attr()
  password: DS.attr()
  passwordConfirmation: DS.attr()
  slug: DS.attr()

  upload: DS.belongsTo 'upload'
)