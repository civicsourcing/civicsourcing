# For more information see: http://emberjs.com/guides/routing/

CivicSourcing.Router.map ()->
  @route 'home', path: '/'
  @route 'login'
  @route 'register'
  @resource 'static', ->
    @route 'how-it-works', path: 'how-it-works'
    @route 'about', path: 'about'
    @route 'contact', path: 'contact'
  @resource 'dashboard', ->
    @resource 'dashboard.feed', path: 'feed'
    @resource 'dashboard.initiatives', path: 'initiatives'
    @resource 'dashboard.communities', path: 'communities', ->
      @route 'new'
      @resource 'dashboard.communities.community', path: ':community_id'
    @resource 'dashboard.reputation', path: 'reputation'

CivicSourcing.Router.reopen
  location: "history"