Ember.Application.initializer
  name: "authentication"
  initialize: (container, application) ->
    Ember.SimpleAuth.Session.reopen
      currentUser: (->
        userId = @get('content.user_id');
        if !Ember.isEmpty(userId)
          container.lookup('store:main').find('user', userId)
      ).property('content')

    container.injection("component", 'session', 'ember-simple-auth:session:current');
    Ember.SimpleAuth.setup container, application

Ember.SimpleAuth.Authenticators.Devise.reopen
  serverTokenEndpoint: '/api/v1/users/sign_in'

Ember.SimpleAuth.reopen
  routeAfterAuthentication: 'dashboard.feed'
  routeAfterInvalidation: 'home'