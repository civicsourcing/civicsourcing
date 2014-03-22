CivicSourcing.CommunityCategorySetAutocompleteComponent = Em.Component.extend

  tagName: 'span'
  classNames: 'input-width'
  searchInput: null

  setSearchInput: (->
    communityCategory = @get 'targetObject.communityCategory'
    if communityCategory?
      communityCategory.get('name')
  ).on('didInsertElement')

  communityCategories: (->
    input = @get 'searchInput'
    communityCategory = @get 'targetObject.communityCategory'
    if input? && input.length > 2 && (!communityCategory? || input != communityCategory.get('name'))
      @store.findQuery 'communityCategory',
        name: input
  ).property('searchInput')

  actions:
    setCommunityCategory: (communityCategory) ->
      formObject = @get('targetObject')
      formObject.set("communityCategory", communityCategory)
      @set('searchInput', communityCategory.get('name'))