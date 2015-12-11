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
      editTitleInput: '[data-js-todo-edit-title]'
      buttonDelete: '[data-js-todo-delete]'
      buttonEdit: '[data-js-todo-edit]'

    events:
      'click [data-js-todo-done]': 'onDoneClick'
      'click [data-js-todo-delete]': 'onDeleteClick'
      'click [data-js-todo-edit]': 'onEditClick'

    bindings:
      '[data-js-todo-id]': "attr: {'data-js-todo-id': id}"
      '[data-js-todo-title]': 'text: title'
      '[data-js-todo-done]': 'checked: done'

    initialize: ->
      @$el.html @template
      @render()
      @_setUi()
      @listenTo @model, 'change', @render
      @listenTo @model, 'destroy', @remove

    # REVIEW: этот метод используется несколько раз, лучше вынести его в общего родителя
    _setUi: ->
      ui = {}
      _.each @ui, (element, key)=>
        ui[key] = @$(element)
      @ui = ui

    # _toggleEditMode: ->
    #   isTitleHidden = @ui.title.hasClass 'hidden'
    #   @ui.title.toggleClass 'hidden', !isTitleHidden
    #   @ui.editTitleInput.toggleClass 'hidden', isTitleHidden

    # _changeTitle: ->
    #   @model.changeTitle @ui.editTitleInput.val()
    #   @_toggleEditMode()

    onEditClick: ->

    onDoneClick: -> @model.toggle()

    onDeleteClick: -> @model.destroy()

    # onEditTitleBlur: -> @_changeTitle()

    # onEditTitleKeypress: (e)-> @_changeTitle() if (e.keyCode == 13)

  TodoListView = Backbone.Epoxy.View.extend
    events:
      'click [data-js-todo-title]': 'showItemPage'

    className: 'todo-list'

    initialize: ->
      @render()
      @listenTo @collection, 'sync', @render

    render: ->
      @$el.html ''
      @collection.each (todoModel)=>
        todoItemView = new TodoItemView model: todoModel
        @$el.append todoItemView.$el
      this

    # showItemPage: (e) ->
    #   # REVIEW: можно же было просто использовать ссылку
    #   # REVIEW: да и с parent не очень красиво
    #   itemId = $(e.currentTarget).parent().attr 'data-js-todo-id'
    #   window.common.router.navigate '/items/' + itemId, {trigger: true}
