CivicSourcing.DashboardCommunitiesCommunityRoute = Ember.Route.extend(

  serialize: (model) ->
    community_id: model.get('slug')
)