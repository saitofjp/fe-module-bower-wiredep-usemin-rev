module.exports = (grunt) ->
  config =
     app:"public"
     dist:"dist"

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    config:config

    wiredep:
      app:
        src: ['<%= config.app %>/{,*/}*.html']
        exclude: []

    useminPrepare:
        options: {
          dest: '<%= config.dist %>'
        }
        html: '<%= config.app %>/{,*/}*.html'

    copy:
      dist:
        files: [{
          expand: true,
          dot: true,
          cwd: '<%= config.app %>'
          dest: '<%= config.dist %>'
          src: [
            '{,*/}*.html'
          ]
        }]

    #Renames files for browser caching purposes
    rev:
      dist:
        files: [{
          src: [
            '<%= config.dist %>/scripts/{,*/}*.js',
            '<%= config.dist %>/styles/{,*/}*.css',
            '<%= config.dist %>/images/{,*/}*.*',
            '<%= config.dist %>/styles/fonts/{,*/}*.*',
            '<%= config.dist %>/*.{ico,png}'
          ]
        }]

    usemin:
      options: {
        dirs: ['dist']
      }
      html: ['<%= config.dist %>/{,*/}*.html']

    clean:
      dist:
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= config.dist %>/*',
          ]
        }]

  # Load task

  grunt.loadNpmTasks 'grunt-usemin'
  grunt.loadNpmTasks 'grunt-wiredep'
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-rev"

  grunt.registerTask('build', [ 'clean:dist', 'useminPrepare', 'concat', 'uglify', 'cssmin', "copy:dist", "rev:dist", 'usemin'])
