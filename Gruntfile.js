'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    uglify:{
       "ani-render": {
            files: {
               'dist/sgf-ani-render.min.js': ['lib/BinFileReader.js', 'lib/raphael-min.js', 'lib/sgf-ani-render.js']
                                  }
                         }
            }
  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-uglify');

  // Default task.
  grunt.registerTask('default', ['uglify']);

};
