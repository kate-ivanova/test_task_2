define (require, exports, module) ->
  Backbone = require 'backbone'
  _Page = require '../_Page'
  require 'backbone.epoxy'
  TodoCollection = require 'collection/TodoCollection'
  TodoItemPageTemplate = require 'jade!view/page/TodoItemPage/TodoItemPage'

  TodoItemPage = _Page.extend

    className: 'todo-item'

    template: TodoItemPageTemplate()

    ui:
      title: '[data-js-todo-title]'
      done: '[data-js-todo-done]'
      editTitle: '[data-js-todo-edit-title]'
      buttonEdit: '[data-js-todo-edit]'
      buttonSave: '[data-js-todo-save]'
      buttonCancel: '[data-js-todo-cancel]'

    events:
      'click [data-js-todo-done]': 'onDoneClick'
      'click [data-js-todo-edit]': 'onEditButtonClick'
      'click [data-js-todo-save]': 'onSaveButtonClick'
      'click [data-js-todo-cancel]': 'onCancelButtonClick'
      'keydown [data-js-todo-edit-title]': 'onEditTitleKeydown'

    bindings:
      '[data-js-todo-title]': 'text: title'
      '[data-js-todo-done]': 'checked: done'

    initialize: (@model)->
      @$el.html @template
      @_setUi()

    _setUi: ->
      ui = {}
      _.each @ui, (element, key)=>
        ui[key] = @$(element)
      @ui = ui

    _toggleEditMode: ->
      @ui.editTitle.val(@model.get 'title')
      @$el.toggleClass 'todo-item__edit'

    _saveChanges: ->
      @model.set {title: @ui.editTitle.val()}
      @_toggleEditMode()

    onEditButtonClick: -> @_toggleEditMode()

    onSaveButtonClick: -> @_saveChanges()

    onCancelButtonClick: -> @_toggleEditMode()

    onEditTitleKeydown: (e)-> @_saveChanges() if e.keyCode == 13
