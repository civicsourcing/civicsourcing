(function(global) {

var define, requireModule;

(function() {
  var registry = {}, seen = {};

  define = function(name, deps, callback) {
    registry[name] = { deps: deps, callback: callback };
  };

  requireModule = function(name) {
    if (seen.hasOwnProperty(name)) { return seen[name]; }
    seen[name] = {};

    if (!registry[name]) {
      throw new Error("Could not find module " + name);
    }

    var mod = registry[name],
        deps = mod.deps,
        callback = mod.callback,
        reified = [],
        exports;

    for (var i=0, l=deps.length; i<l; i++) {
      if (deps[i] === 'exports') {
        reified.push(exports = {});
      } else {
        reified.push(requireModule(resolve(deps[i])));
      }
    }

    var value = callback.apply(this, reified);
    return seen[name] = exports || value;

    function resolve(child) {
      if (child.charAt(0) !== '.') { return child; }
      var parts = child.split("/");
      var parentBase = name.split("/").slice(0, -1);

      for (var i=0, l=parts.length; i<l; i++) {
        var part = parts[i];

        if (part === '..') { parentBase.pop(); }
        else if (part === '.') { continue; }
        else { parentBase.push(part); }
      }

      return parentBase.join("/");
    }
  };

  requireModule.registry = registry;
})();

define("ember-simple-auth-devise", 
  ["./ember-simple-auth-devise/authenticators/devise","./ember-simple-auth-devise/authorizers/devise","exports"],
  function(__dependency1__, __dependency2__, __exports__) {
    "use strict";
    var Authenticator = __dependency1__.Devise;
    var Authorizer = __dependency2__.Devise;

    __exports__.Authenticator = Authenticator;
    __exports__.Authorizer = Authorizer;
  });
define("ember-simple-auth-devise/authenticators/devise", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var global = (typeof window !== 'undefined') ? window : {},
        Ember = global.Ember;

    /**
      Authenticator for use with Devise.

      This authenticator supports Devise's rememberable module.

      @class Devise
      @namespace Authenticators
      @extends Base
    */

    var Devise = Ember.SimpleAuth.Authenticators.Base.extend({
      /**
        The endpoint on the server the authenticator acquires the auth token
        from.

        @property serverTokenEndpoint
        @type String
        @default '/users/sign_in'
      */
      serverTokenEndpoint: '/users/sign_in',

      /**
        Restores the session from a set of session properties; __will return a
        resolving promise when there's a non-empty `auth_token` in the
        `properties`__ and a rejecting promise otherwise.

        @method restore
        @param {Object} properties The properties to restore the session from
        @return {Ember.RSVP.Promise} A promise that when it resolves results in the session being authenticated
      */
      restore: function(properties) {
        return new Ember.RSVP.Promise(function(resolve, reject) {
          if (!Ember.isEmpty(properties.auth_token) && !Ember.isEmpty(properties.auth_email)){
            return Ember.run(function() {
              return resolve(properties);
            });
          }
          else{
            return reject();
          }
        });
      },

      /**
        Authenticates the session with the specified `credentials`; the credentials
        are `POST`ed to the `serverTokenEndpoint` and if they are valid the server
        returns an auth token in response . __If the credentials are
        valid and authentication succeeds, a promise that resolves with the
        server's response is returned__, otherwise a promise that rejects with the
        error is returned.

        @method authenticate
        @param {Object} options The credentials to authenticate the session with
        @return {Ember.RSVP.Promise} A promise that resolves when an auth token is successfully acquired from the server and rejects otherwise
      */
      authenticate: function(credentials) {
        var _this = this;
        return new Ember.RSVP.Promise(function(resolve, reject) {
          var data = {
            email: credentials.identification,
            password: credentials.password
          };
          return _this.makeRequest(data, resolve, reject);
        });
      },

      /**
        Cancels any outstanding automatic token refreshes.

        @method invalidate
        @return {Ember.RSVP.Promise} A resolving promise
      */
      invalidate: function() {
        Ember.run.cancel(this._refreshTokenTimeout);
        delete this._refreshTokenTimeout;
        return new Ember.RSVP.Promise(function(resolve) {
          return resolve();
        });
      },

      /**
        Sends an `AJAX` request to the `serverTokenEndpoint`. This will always be a
        _"POST_" request with content type _"application/x-www-form-urlencoded".

        This method is not meant to be used directly but serves as an extension
        point to e.g. add _"Client Credentials".

        @method makeRequest
        @param {Object} data The data to send with the request, e.g. email and password or the auth_token
        @return {Ember.RSVP.Promise} A promise that resolves when a auth_token is successfully acquired from the server and rejects otherwise
        @protected
      */
      makeRequest: function(data, resolve, reject) {
        return Ember.$.ajax({
          url: this.serverTokenEndpoint,
          type: "POST",
          data: data,
          dataType: "json",
          contentType: "application/x-www-form-urlencoded"
        }).then((function(response) {
          return Ember.run(function() {
            return resolve(response);
          });
        }), function(xhr, status, error) {
          return Ember.run(function() {
            return reject(xhr.responseText);
          });
        });
      }
    });

    __exports__.Devise = Devise;
  });
define("ember-simple-auth-devise/authorizers/devise", 
  ["exports"],
  function(__exports__) {
    "use strict";
    var global = (typeof window !== 'undefined') ? window : {},
        Ember = global.Ember;

    /**
      Authorizer that conforms to Devise by sending an auth_token in the request's
      `auth-token` header.

      _The factory for this authorizer is registered as
      `'authorizer:devise'` in Ember's container.

      @class Devise
      @namespace Authorizers
      @extends Base
    */
    var Devise = Ember.SimpleAuth.Authorizers.Base.extend({
      /**
        Authorizes an XHR request by sending the `auth_token` property from the
        session as a bearer token in the `Authorization` header:

        ```
        Authorization: Bearer <auth_token>
        ```

        @method authorize
        @param {jqXHR} jqXHR The XHR request to authorize (see http://api.jquery.com/jQuery.ajax/#jqXHR)
        @param {Object} requestOptions The options as provided to the `$.ajax` method (see http://api.jquery.com/jQuery.ajaxPrefilter/)
      */

      authorize: function(jqXHR, requestOptions) {
        if (!Ember.isEmpty(this.get('session.auth_token')) && !Ember.isEmpty(this.get('session.auth_email'))) {
          jqXHR.setRequestHeader('auth-token', this.get('session.auth_token'));
          jqXHR.setRequestHeader('auth-email', this.get('session.auth_email'));
        }
      }
    });

    __exports__.Devise = Devise;
  });
var devise = requireModule('ember-simple-auth-devise');

global.Ember.SimpleAuth.Authenticators.Devise = devise.Authenticator;
global.Ember.SimpleAuth.Authorizers.Devise    = devise.Authorizer;

global.Ember.SimpleAuth.initializeExtension(function(container, application, options) {
  container.register('authorizer:devise', global.Ember.SimpleAuth.Authorizers.Devise);
  container.register('authenticator:devise', global.Ember.SimpleAuth.Authenticators.Devise);
});
})((typeof global !== 'undefined') ? global : window);
