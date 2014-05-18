CivicSourcing.Initiative = CivicSourcing.Amorphous.extend(
  CivicSourcing.GroupMixin

  user: DS.belongsTo "user"
  community: DS.belongsTo "community"
  fund: DS.belongsTo "fund"
  petition: DS.belongsTo "petition"
  workroom: DS.belongsTo "workroom"

  description: DS.attr()
  name: DS.attr()
  slug: DS.attr()
  featured: DS.attr()

  upload: DS.belongsTo 'upload'

  logoUrl: (->
    uploadUrl = @get("upload.file.file.url")
    if uploadUrl? then uploadUrl else @get('community.logoUrl')
  ).property("upload.file.file.url")
)