#= require jquery
#= require jquery_ujs
#= require jquery.ui.datepicker
#= require jquery-fileupload/basic
#= require jquery-fileupload/vendor/tmpl
#= require_tree ./addons
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require civic_sourcing

# for more details see: http://emberjs.com/guides/application/
window.CivicSourcing = Ember.Application.create()

Ember.TextField.reopen
  attributeBindings: ['accept', 'autocomplete', 'autofocus', 'name', 'required']

Ember.Select.reopen
  classNames: ["customSelect"]

  applyCustomSelect: (->
    $(".customSelect").each (i) ->
      $(this).customSelect()
  ).on('didInsertElement')

Ember.Checkbox.reopen
  classNames: ["css-checkbox"]