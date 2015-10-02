define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoItemView = require 'todoItemView'
  $ = Backbone.$

  TodoListView = Backbone.Epoxy.View.extend
    ui:
      $title: $('[data-js-todo-title]')

    events:
      'click [data-js-todo-title]': 'showItemPage'

    setCollection: (collection)->
      @collection = collection
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







