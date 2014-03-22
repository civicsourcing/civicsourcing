CivicSourcing.AdminCommunityCategoriesIndexRoute = Ember.Route.extend(

  model: ->
    @store.findAll 'communityCategory'
      
)