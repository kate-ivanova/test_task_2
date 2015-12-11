define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  AddTodoWidgetTemplate = require 'jade!view/widget/AddTodoWidget/AddTodoWidget'

  $ = Backbone.$

  AddTodoWidget = Backbone.Epoxy.View.extend
    template: AddTodoWidgetTemplate()
    className: 'add-todo-widget'

    ui:
      title: '[data-js-todo-title]'
      addButton: '[data-js-todo-add]'

    events:
      'click [data-js-todo-add]': 'onAddButtonClick'
      'keydown [data-js-todo-title]': 'onTitleKeydown'

    initialize: ->
      @$el.html @template
      @render()
      @_setUi()

    _setUi: ->
      ui = {}
      _.each @ui, (element, key)=>
        ui[key] = @$(element)
      @ui = ui

    _addTodo: ->
      @collection.add title: @ui.title.val()
      @ui.title.val ''

    # название не совсем правдивое
    onAddButtonClick: -> @_addTodo()

    onTitleKeydown: (e)-> @_addTodo() if e.keyCode == 13
