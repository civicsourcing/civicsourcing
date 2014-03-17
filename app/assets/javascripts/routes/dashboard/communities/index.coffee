CivicSourcing.DashboardCommunitiesIndexRoute = Ember.Route.extend(

  model: ->
    @store.findQuery 'membership',
      member_type: "User"
      member_id: @session.get('content.user_id')
      group_type: "Community"
      
)