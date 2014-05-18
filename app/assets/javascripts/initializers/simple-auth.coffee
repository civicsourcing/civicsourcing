Ember.Application.initializer
  name: "authentication"
  initialize: (container, application) ->
    Ember.SimpleAuth.setup container, application,
      authorizerFactory: "authorizer:devise"
      routeAfterAuthentication: 'dashboard.feed'
      routeAfterInvalidation: 'home'

    container.lookup('session:main').reopen
      currentUser: (->
        userId = @get('content.user_id')
        if !Ember.isEmpty(userId)
          container.lookup('store:main').find('user', userId)
      ).property('content')
      setCard: (value) ->
        @set('content.card_registered', value)
      currentUserHasCard: (->
        @get('content.card_registered')
      ).property('content.card_registered')
      setBank: (value) ->
        @set('content.bank_registered', value)
      currentUserHasBank: (->
        @get('content.bank_registered')
      ).property('content.bank_registered')

    container.injection("component", 'session', 'session:main')
    container.injection("view", 'session', 'session:main')