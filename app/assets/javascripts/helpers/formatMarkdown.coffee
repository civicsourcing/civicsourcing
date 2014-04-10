Ember.Handlebars.helper "formatMarkdown", (input) ->
  if input?
    new Handlebars.SafeString(CivicSourcing.markdown.makeHtml(input))