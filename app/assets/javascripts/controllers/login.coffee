CivicSourcing.LoginController = Ember.Controller.extend(
  Ember.SimpleAuth.LoginControllerMixin,
    authenticator: "ember-simple-auth:authenticators:devise"
)