require.config
  baseUrl: '.'
  packages: ['js/main']
  paths:
    angular: 'bower_components/angular/angular'
    bootstrap: 'bower_components/angular-bootstrap/ui-bootstrap-tpls'
    router: 'bower_components/angular-ui-router/release/angular-ui-router'
    text: 'bower_components/requirejs-text/text'
    tpl: 'js/lib/tpl'
    requireLib: 'bower_components/requirejs/require'

  shim:
    angular:
      exports: 'angular'
    bootstrap:
      deps: ['angular']
    router:
      deps: ['angular']

  modules: [
    name: 'js/main'
    include: ['requireLib']
  ]

  optimize: 'uglify2'

  generateSourceMaps: false