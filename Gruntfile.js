'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    uglify:{
       my_target: {
            files: {
               'dist/sgf-ani-render.min.js': ['lib/BinFileReader.js', 'lib/raphael-min.js', 'lib/sgf-ani-render.js']
                                  }
                         }
            },
            //concat: {
                      //options: {
                                 //separator: ';'
                               //},
    //dist: {
            //src: ['lib/BinFileReader.js', 'lib/raphael-min.js', 'lib/sgf-ani-render.js'],
    //dest: 'dist/built.js'
          //}
                    //},

  });

  // These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-uglify');
  //grunt.loadNpmTasks('grunt-contrib-concat');

  // Default task.
  //grunt.registerTask('default', ['concat', 'uglify']);
  grunt.registerTask('default', ['uglify']);

};
