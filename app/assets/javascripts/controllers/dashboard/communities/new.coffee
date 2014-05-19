CivicSourcing.DashboardCommunitiesNewController = Ember.ObjectController.extend(

  CivicSourcing.CommunityCategorySelectMixin

  CivicSourcing.FormMixin,
    transitionTo: 'dashboard.communities.community'
        
)