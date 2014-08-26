module.exports = (grunt) ->
  getCopyConfig = (mode) ->
    global =
      expand: true
      cwd: 'app'
      src: ['**', '!**/*.coffee']
      dest: 'target'
      options:
        noProcess: ['**/*.{png,gif,jpg,ico,svg,ttf,eot,woff}']
    switch mode
      when 'dev'
        global.options.process = (content) -> content.replace /@dev{([\s\S]*)}/, (match, body) -> body.trim()
      when 'prod'
        global.options.process = (content) -> content.replace /@dev{([\s\S]*)}/, ''
    global

  grunt.initConfig
    watch:
      compile:
        files: ['app/**']
        tasks: ['compile']
        options:
          spawn: false

    coffee:
      compile:
        expand: true
        cwd: 'app'
        src: ['**/*.coffee']
        dest: 'target'
        ext: '.js'

    clean:
      target: 'target'
      dist: ['dist/lib', 'dist/build.txt', 'dist/config.js']

    copy:
      compile: getCopyConfig 'dev'
      dist: getCopyConfig 'prod'

    requirejs:
      dist:
        options:
          mainConfigFile: 'target/config.js'
          appDir: 'target'
          dir: 'dist'

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerTask 'default', ['watch:compile']
  grunt.registerTask 'compile', ['clean:target', 'copy:compile', 'coffee:compile']
  grunt.registerTask 'compileDist', ['clean:target', 'copy:dist', 'coffee:compile']
  grunt.registerTask 'dist', ['compileDist', 'requirejs', 'clean:dist']