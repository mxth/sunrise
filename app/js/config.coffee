require.config
  baseUrl: '.'
  paths:
    pixi: 'lib/pixi.dev'
    underscore: 'lib/underscore'
    requireLib: 'lib/require'

  shim:
    pixi:
      exports: 'PIXI'
    underscore:
      exports: '_'

  modules: [
    name: 'pairs/main'
    include: ['requireLib']
  ]

  optimize: 'uglify2'

  generateSourceMaps: false


