# For more information see: http://emberjs.com/guides/routing/

CivicSourcing.Router.map ()->
  @route 'home', path: '/'
  @route 'confirm'
  @route 'login'
  @route 'register'
  @resource 'static', ->
    @route 'how-it-works', path: 'how-it-works'
    @route 'about', path: 'about'
    @route 'contact', path: 'contact'
  @resource 'dashboard', ->
    @resource 'dashboard.feed', path: 'feed'
    @resource 'dashboard.initiatives', path: 'initiatives', ->
      @route 'new'
      @resource 'dashboard.initiatives.initiative', path: ':initiative_id'
    @resource 'dashboard.communities', path: 'communities', ->
      @route 'new'
      @resource 'dashboard.communities.community', path: ':community_id', ->
        @route 'edit'
    @resource 'dashboard.reputation', path: 'reputation'
  @resource 'initiative', path: 'initiative/:initiative_id', ->
    @route 'edit'
    @resource 'initiative.feed', path: 'feed'
    @resource 'initiative.task', path: 'task'
    @resource 'initiative.event', path: 'event'
    @resource 'initiative.petition', path: 'petition'
    @resource 'initiative.fund', path: 'fund'
  @resource 'petition', path: 'petition/:petition_id', ->
    @route 'edit'
  @resource 'admin', ->
    @resource 'admin.community-categories', path: 'community-categories', ->
      @route 'new'
      @resource 'admin.community-categories.community-category',
        path: 'community-category/:community_category_id'

CivicSourcing.Router.reopen
  location: "history"