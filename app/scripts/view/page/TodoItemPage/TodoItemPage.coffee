define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoCollection = require 'todoCollection'
  TodoItemView = require 'todoItemView'

  TodoItemPage = Backbone.View.extend
    setAttributes: (attrs)->
      @todoItem = @collection.get attrs.todoItemId

    render: ->
      todoItemView = new TodoItemView model: @todoItem
      todoItemView.render()
      $todoItemEl = todoItemView.$el
      @$el.html $todoItemEl
