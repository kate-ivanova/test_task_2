define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoItemView = require 'todoItemView'
  common = require 'common'
  $ = Backbone.$

  TodoListView = Backbone.View.extend

    events:
      'click [data-js-todo-title]': 'showItemPage'

    initialize: ->
      @listenTo @collection, 'update', @render

    render: ->
      @$el.html ''
      @collection.each (todoModel)=>
        @renderTodo todoModel
      this

    renderTodo: (todoModel)->
      todoItemView = new TodoItemView model: todoModel
      todoItemView.render()
      $todoItemEl = todoItemView.$el
      @$el.append $todoItemEl

    showItemPage: (e) ->
      itemId = $(e.currentTarget).parent().attr 'data-js-todo-id'
      window.common.router.navigate '/items/' + itemId, {trigger: true}







