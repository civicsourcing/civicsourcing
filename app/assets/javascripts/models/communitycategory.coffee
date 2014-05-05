CivicSourcing.CommunityCategory = CivicSourcing.Amorphous.extend(
  communities: DS.hasMany 'community',
    async: true 

  name: DS.attr()
)