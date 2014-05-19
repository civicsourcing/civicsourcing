CivicSourcing.CommunityCategorySelectMixin = Ember.Mixin.create(

  categories: null

  init: ->
    categories = @store.find('communityCategory')
    @set('categories', categories)

)