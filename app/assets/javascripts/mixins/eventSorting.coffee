CivicSourcing.EventSortingMixin = Ember.Mixin.create(
  currentSortMethod: null
  sortAscending: null
  sortProperties: null

  sortMethods: [
    name: "New"
    id: 'new'
    sortAscending: false
    sortProperties: ["updatedAt"]
  ,
    name: "Hot"
    id: 'hot'
    sortAscending: false
    sortProperties: ["childrenCount"]
  ,
    name: "Popular"
    id: "popular"
    sortAscending: false
    sortProperties: ["popularity", "votesSum"]
  ,
    name: "Controversial"
    id: "controversial"
    sortAscending: false
    sortProperties: ["controversy"]
  ]

  sortMethodObserver: (->
    @set("sortAscending", @get("currentSortMethod.sortAscending"))
    @set("sortProperties", @get("currentSortMethod.sortProperties"))
  ).observes("currentSortMethod")

)