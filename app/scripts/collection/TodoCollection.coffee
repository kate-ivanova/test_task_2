define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoModel = require 'model/TodoModel'
  localStorage = require 'backbone.localStorage'

  TodoCollection = Backbone.Collection.extend
    model: TodoModel

    localStorage: new Backbone.LocalStorage "todolist-backbone"

    initialize: ->
      @fetch()
      @listenTo this, 'add', @change
      @listenTo this, 'remove', @change

    change: ->
      @trigger 'change'
      @postData()

    postData: ->
      @sync 'update', this




