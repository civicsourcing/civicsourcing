Ember.Handlebars.helper 'getYear', (date, options) ->
  year = new Date(date).getFullYear()
  new Handlebars.SafeString year