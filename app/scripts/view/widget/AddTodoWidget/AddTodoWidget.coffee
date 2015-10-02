define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoCollection = require 'todoCollection'
  $ = Backbone.$

  AddTodoWiget = Backbone.Epoxy.View.extend
    template: $('#AddTodoWidget').html()

    className: 'add-todo-widget'

    ui:
      $title: $('[data-js-todo-title]')

    events:
      'click [data-js-todo-add]': 'onAddClick'
      'keypress [data-js-todo-title]': 'onTitleKeypress'

    render:->
      @$el.html @template

    onAddClick: ->
      @addTodoItem @ui.$title.val()
      @ui.$title.val ''

    onTitleKeypress: (e)->
      @onAddClick() if (e.keyCode == 13)

    addTodoItem: (title)->
       @collection.addNewItem title: title
