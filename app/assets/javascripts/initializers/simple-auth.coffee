Ember.Application.initializer
  name: "authentication"
  initialize: (container, application) ->
    Ember.SimpleAuth.setup container, application,
      authorizerFactory: "authorizer:devise"
      routeAfterAuthentication: 'dashboard.feed'
      routeAfterInvalidation: 'home'

    container.lookup('session:main').reopen
      currentUser: (->
        userId = @get('content.user_id');
        if !Ember.isEmpty(userId)
          container.lookup('store:main').find('user', userId)
      ).property('content')
    container.injection("component", 'session', 'session:main')