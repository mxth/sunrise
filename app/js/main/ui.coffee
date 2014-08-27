define [
  'angular'
  'tpl!main/home'
  'tpl!main/about'
  'tpl!main/blog'
  'tpl!main/contact'
  'router'], (
  angular
  homeTpl
  aboutTpl
  blogTpl
  contactTpl
) ->
  config = ($urlRouterProvider, $stateProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider
      .state 'home',
        url: '/'
        views:
          'root':
            template: homeTpl
            controller: 'HomeCtrl as home'
      .state 'about',
        url: '/about'
        views:
          'root':
            template: aboutTpl
      .state 'blog',
        url: '/blog'
        views:
          'root':
            template: blogTpl
      .state 'contact',
        url: '/contact'
        views:
          'root':
            template: contactTpl

    return

  angular
    .module 'main.ui', ['ui.router']
    .config ['$urlRouterProvider', '$stateProvider', config]
