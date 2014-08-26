define [
  'angular'
  'tpl!main/home'
  'router'], (
  angular
  homeTpl
) ->
  config = ($urlRouterProvider, $stateProvider) ->
    $urlRouterProvider.otherwise('/')

    $stateProvider
    .state 'home',
      url: '/'
      views:
        'root':
          template: homeTpl
    return

  angular
    .module 'main.ui', ['ui.router']
    .config ['$urlRouterProvider', '$stateProvider', config]
