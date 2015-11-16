define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoModel = require 'model/TodoModel'
  localStorage = require 'backbone.localStorage'

  TodoCollection = Backbone.Collection.extend
    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-backbone"

    initialize: ->
      @fetch()
      @listenTo this, 'change', @yield

    addNewItem: (options)->
      @add options
      @yield()
      this

    yield: ->
      @sync 'update', this




