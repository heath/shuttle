module.exports = (grunt) ->
  pkg = require './package.json'
  grunt.initConfig
    pkg: pkg

    coffee:
      compile:
        files: [
          cwd    : 'src/'
          dest   : 'lib/'
          expand : true
          ext    : '.js'
          src    : [ '**/*.coffee' ]
        ]
    watch:
      scripts:
        files : [ 'src/**/*.coffee' ]
        tasks : [ 'coffee:compile' ]

  for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
    grunt.loadNpmTasks name

  grunt.registerTask 'default', [
    'coffee:compile'
    'watch'
  ]
