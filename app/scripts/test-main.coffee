TEST_REGEXP = /\.test\.js$/i
allTestFiles = []

# Get a list of all the test files to include
(Object.keys window.__karma__.files).forEach (file) ->
  if TEST_REGEXP.test(file)
    # Normalize paths to RequireJS module names.
    # If you require sub-dependencies of test files to be loaded as-is (requiring file extension)
    # then do not normalize the paths
    normalizedTestModule = file.replace(/^\/base\/app\/scripts\/|\.js$/g, '')
    allTestFiles.push normalizedTestModule
  return

# debugger

require.config
  # Karma serves files under /base, which is the basePath from your config file
  baseUrl: '/base/app/scripts/'
   # dynamically load all test files
  deps: allTestFiles
  # we have to kickoff jasmine, as it is asynchronous
  callback: window.__karma__.start
  # example of using a couple path translations (paths), to allow us to refer to different library dependencies, without using relative paths
  paths:
    'jquery': '../../bower_components/jquery/dist/jquery'
    'underscore': '../../bower_components/underscore/underscore'
    'modernizr': '../../bower_components/modernizr/modernizr'
    'backbone': '../../bower_components/backbone/backbone'
    'backbone.epoxy': '../../bower_components/backbone.epoxy/backbone.epoxy'
    'backbone.localStorage': '../../bower_components/backbone.localStorage/backbone.localStorage'
