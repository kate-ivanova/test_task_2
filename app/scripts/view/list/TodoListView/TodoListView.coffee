define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoItemViewTemplate = require 'jade!view/list/TodoListView/TodoItemView'
  $ = Backbone.$

  # REVIEW: Деление на айтемы и листы на уровне компонентов не очень оправдано
  # все было бы очень аккуратно, если бы TodoItem и TodoList лежали вместе
  # REVIEW: да и деление на прочие виджеты тоже не вполне оправдано,
  # даваай положим все вместе и назовем components ;)
  # Всё кроме страниц

  TodoItemView = Backbone.Epoxy.View.extend
    template: TodoItemViewTemplate()

    className: 'todo-list--item'

    ui:
      id: '[data-js-todo-id]'
      title: '[data-js-todo-title]'
      done: '[data-js-todo-done]'
      buttonView: '[data-js-todo-view]'
      buttonDelete: '[data-js-todo-delete]'

    events:
      'click [data-js-todo-view]': 'onViewButtonClick'
      'click [data-js-todo-delete]': 'onDeleteButtonClick'

    bindings:
      '[data-js-todo-title]': 'text: title'
      '[data-js-todo-done]': 'checked: done'

    initialize: ->
      @$el.html @template
      @render()
      @_setUi()
      @listenTo @model, 'change', @render
      @listenTo @model, 'destroy', @remove

    showItemPage: -> window.common.router.navigate '/items/' + (@model.get 'id'), {trigger: true}


    # REVIEW: этот метод используется несколько раз, лучше вынести его в общего родителя
    _setUi: ->
      ui = {}
      _.each @ui, (element, key)=>
        ui[key] = @$(element)
      @ui = ui

    onViewButtonClick: -> @showItemPage()

    onDeleteButtonClick: -> @model.destroy()

  TodoListView = Backbone.Epoxy.View.extend
    events:
      'click [data-js-todo-title]': 'showItemPage'

    className: 'todo-list'

    initialize: ->
      @render()
      @listenTo @collection, 'refresh', @render

    render: ->
      @$el.html ''
      @collection.each (todoModel)=>
        todoItemView = new TodoItemView model: todoModel
        @$el.append todoItemView.$el
      this
