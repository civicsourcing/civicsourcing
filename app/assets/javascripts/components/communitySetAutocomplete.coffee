CivicSourcing.CommunitySetAutocompleteComponent = Em.Component.extend

  tagName: 'span'
  classNames: 'input-width'
  searchInput: null

  setSearchInput: (->
    community = @get 'targetObject.community'
    if community?
      community.get('name')
  ).on('didInsertElement')

  communities: (->
    input = @get 'searchInput'
    community = @get 'targetObject.community'
    if input? && input.length > 2 && (!community? || input != community.get('name'))
      @store.findQuery 'community',
        name: input
  ).property('searchInput')

  actions:
    setCommunity: (community) ->
      formObject = @get('targetObject')
      formObject.set("community", community)
      @set('searchInput', community.get('name'))