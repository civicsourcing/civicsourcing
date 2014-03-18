CivicSourcing.DashboardInitiativesIndexRoute = Ember.Route.extend(

  model: ->
    @store.findQuery 'membership',
      member_type: "User"
      member_id: @session.get('content.user_id')
      group_type: "Initiative"
      
)