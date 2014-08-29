require.config
  baseUrl: '.'
  packages: ['js/main']
  paths:
    angular: 'bower_components/angular/angular'
    bootstrap: 'bower_components/angular-bootstrap/ui-bootstrap-tpls'
    router: 'bower_components/angular-ui-router/release/angular-ui-router'
    text: 'bower_components/requirejs-text/text'
    tpl: 'js/common/tpl'
    requireLib: 'bower_components/requirejs/require'
    config: 'js/config'

  shim:
    angular:
      exports: 'angular'
    bootstrap:
      deps: ['angular']
    router:
      deps: ['angular']

  modules: [
    name: 'js/boot'
    include: ['requireLib', 'config']
  ]

  optimize: 'uglify2'
  optimizeCss: 'standard.keepLines'
  generateSourceMaps: false
  preserveLicenseComments: false
