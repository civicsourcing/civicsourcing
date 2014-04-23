CivicSourcing.LoginRoute = Ember.Route.extend(
  setupController: (controller, model) ->
    controller.set "loginError", null

  actions:
    sessionAuthenticationFailed: (error) ->
      message = JSON.parse(error).error
      @controller.set "loginError", message
)