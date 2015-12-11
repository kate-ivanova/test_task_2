// Karma configuration
// Generated on Thu Oct 29 2015 09:56:47 GMT+0300 (MSK)

module.exports = function(config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: '',

    plugins: [
      'karma-requirejs',
      'karma-jasmine',
      'karma-jasmine-jquery',
      'karma-sinon',
      'karma-mocha',
      'karma-coffee-preprocessor',
      'karma-chrome-launcher',
      'karma-coverage',
    ],

    // frameworks to use
    // available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['requirejs', 'sinon', 'jasmine-jquery', 'jasmine'],

    // list of files / patterns to load in the browser
    files: [
      'test/test-main.coffee',
      {pattern: 'bower_components/**/*.js', included: false, watched: false},
      {pattern: 'app/scripts/**/*.coffee', included: false, watched: true},
      {pattern: 'app/scripts/**/*.jade', included: false, watched: true},
    ],

    // list of files to exclude
    exclude: [
      'bower_components/**/*test*',
      'app/scripts/main.coffee'
    ],

    // preprocess matching files before serving them to the browser
    // available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors: {
      '**/*.coffee': ['coffee'],
      'app/scripts/model/**/!(*.test).coffee': ['coverage'],
      'app/scripts/collection/**/!(*.test).coffee': ['coverage'],
      'app/scripts/view/**/!(*.test).coffee': ['coverage'],
    },
    // preprocess coffeeScript
    coffeePreprocessor: {
      // options passed to the coffee compiler
      options: {
        bare: true,
        sourceMap: false
      },
      // transforming the filenames
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js')
      }
    },
    // test coverage configiration
    coverageReporter: {
      // specify a common output directory
      dir: 'test/coverage',
      reporters: [
        // reporters not supporting the `file` property
        { type: 'html', subdir: '.' },
        { type: 'text'}
      ]
    },
    // test results reporter to use
    // possible values: 'dots', 'progress'
    // available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['dots', 'progress', 'coverage'],

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

    // enable / disable restarting karma and executing tests whenever any file changes
    restartOnFileChange: true,

    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome'],

    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false,

    // Concurrency level
    // how many browser should be started simultanous
    concurrency: Infinity
  })
}
