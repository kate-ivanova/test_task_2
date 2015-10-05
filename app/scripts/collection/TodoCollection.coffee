define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoModel = require 'todoModel'
  localStorage = require 'backbone.localStorage'

  TodoCollection = Backbone.Collection.extend
    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-backbone"

    initialize: ->
      @fetch()

    addNewItem: (options)->
      @create(options)
      @trigger 'change'
      this

