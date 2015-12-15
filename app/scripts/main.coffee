require.config
  paths:
    jquery: '../bower_components/jquery/dist/jquery'
    underscore: '../bower_components/underscore/underscore'
    modernizr: '../bower_components/modernizr/modernizr'
    backbone: '../bower_components/backbone/backbone'
    'jade': '../bower_components/require-jade/jade'
    'backbone.localStorage': '../bower_components/backbone.localStorage/backbone.localStorage'
    'backbone.epoxy': '../bower_components/backbone.epoxy/backbone.epoxy'

require ['backbone', 'common', 'Router', 'app'], (Backbone, common, Router, App)->
  window.common.app = new App
  window.common.app.initialize()
  window.common.router = new Router
  Backbone.history.start()
