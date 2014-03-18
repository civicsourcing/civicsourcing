CivicSourcing.CommunitySearchAutocompleteComponent = Em.Component.extend

  searchInput: null

  communities: (->
    input = @get 'searchInput'
    if input? && input.length > 2
      @store.findQuery 'community',
        name: input
  ).property('searchInput')

  actions:
    clear: ->
      @set('searchInput', "")