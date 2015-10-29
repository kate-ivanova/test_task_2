define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoItemView = require 'view/list/TodoItemView/TodoItemView'
  $ = Backbone.$

  # REVIEW: Деление на айтемы и листы на уровне компонентов не очень оправдано
  # все было бы очень аккуратно, если бы TodoItem и TodoList лежали вместе
  # REVIEW: да и деление на прочие виджеты тоже не вполне оправдано,
  # даваай положим все вместе и назовем components ;)
  # Всё кроме страниц
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
      # REVIEW: itemView же уже рендерится при создании
      todoItemView.render()
      $todoItemEl = todoItemView.$el
      # REVIEW: по идее лучше эту строку перенести в render
      # REVIEW: а этот метод будет более чистым и будет делать толко 1 вещь
      # REVIEW: возвращать новый объект
      @$el.append $todoItemEl

    showItemPage: (e) ->
      # REVIEW: можно же было просто использовать ссылку
      # REVIEW: да и с parent не очень красиво
      itemId = $(e.currentTarget).parent().attr 'data-js-todo-id'
      window.common.router.navigate '/items/' + itemId, {trigger: true}
