define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoItemView = require 'view/list/TodoItemView/TodoItemView'
  $ = Backbone.$

  TodoListView = Backbone.Epoxy.View.extend
    events:
      'click [data-js-todo-title]': 'showItemPage'

    initialize: ->
      @render()
      @listenTo @collection, 'sync', @render

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
