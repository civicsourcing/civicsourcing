Ember.Handlebars.helper 'displayErrors', (errors, options) ->
  string = "<ul>"
  for key, value of errors
    if value?
      values = value.toString().split(",")
      for item in values
        if key == "base"
          string += "<li>#{item}</li>"
        else
          string += "<li>#{key} #{item}</li>"
  string += "</ul>"
  new Handlebars.SafeString string