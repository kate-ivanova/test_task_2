define (require, exports, module) ->
  Backbone = require 'backbone'
  BackboneMixin = require 'backbone-mixin'
  require 'backbone.epoxy'
  $ = Backbone.$

  TodoItemView = BackboneMixin(Backbone.Epoxy.View).extend
    template: '#todoItem'

    className: 'todo-item'

    ui:
      item: '[data-js-todo-id]'
      title: '[data-js-todo-title]'
      done: '[data-js-todo-done]'
      editButton: '[data-js-todo-edit]'
      editTitleInput: '[data-js-todo-edit-title]'
      deleteButton: '[data-js-todo-delete]'

    events:
      # 'click @ui.done': 'onDoneClick'
      # 'click @ui.deleteButton': 'onDeleteClick'
      # 'click @ui.editButton': 'onEditClick'
      # 'keypress @ui.editTitleInput': 'onEditTitleKeypress'
      'click [data-js-todo-done]': 'onDoneClick'
      'click [data-js-todo-delete]': 'onDeleteClick'
      'click [data-js-todo-edit]': 'onEditClick'
      'keypress [data-js-todo-edit-title]': 'onEditTitleKeypress'

    bindings:
      '@ui.item': "attr: {'data-js-todo-id': id}"
      '@ui.title': 'text: title'
      '@ui.done': 'checked: done'
      '@ui.editTitleInput': 'value: title'

    initialize: ->
      @listenTo @model, 'change', @render
      @listenTo @model, 'destroy', @remove

    onEditClick: ->
      @ui.title.addClass 'hidden'
      @ui.editTitleInput.removeClass 'hidden'

    onEditTitleKeypress: (e)->
      if (e.keyCode == 13)
        @model.changeTitle @ui.editTitleInput.val()
        @ui.title.removeClass 'hidden'
        @ui.editTitleInput.addClass 'hidden'

    onDoneClick: (e)->
      @model.toggle()

    onDeleteClick: ->
      @model.destroy()

    remove: ->
      @$el.remove()
