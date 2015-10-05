define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoItemView = require 'todoItemView'
  $ = Backbone.$

  TodoListView = Backbone.Epoxy.View.extend
    events:
      'click [data-js-todo-title]': 'showItemPage'

    initialize: ->
      @render()
      @listenTo @collection, 'sync', @render
      # console.log @$('[data-js-todo-title]')
      # @$el.on 'click', '[data-js-todo-title]',->
      #   console.log 'clicked'

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
