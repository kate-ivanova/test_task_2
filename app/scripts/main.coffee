require.config
  paths:
    jquery: '../bower_components/jquery/dist/jquery'
    underscore: '../bower_components/underscore/underscore'
    modernizr: '../bower_components/modernizr/modernizr'
    backbone: '../bower_components/backbone/backbone'
    'backbone.localStorage': '../bower_components/backbone.localStorage/backbone.localStorage'
    'backbone.epoxy': '../bower_components/backbone.epoxy/backbone.epoxy'
    'backbone-mixin': '../bower_components/backbone-mixin/build/backbone-mixin'
    todoModel: 'model/TodoModel'
    todoCollection: 'collection/TodoCollection'
    todoFilteredCollection: 'collection/TodoFilteredCollection'
    todoItemView: 'view/list/TodoItemView/TodoItemView'
    todoListView: 'view/list/TodoListView/TodoListView'
    todoItemPage: 'view/page/TodoItemPage/TodoItemPage'
    indexPage: 'view/page/IndexPage/IndexPage'
    router: 'Router'
    app: 'app'
    common: 'common'

require ['backbone', 'common', 'router', 'app'], (Backbone, common, Router, App)->
  window.common.app = new App
  window.common.router = new Router
  Backbone.history.start()
