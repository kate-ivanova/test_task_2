define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'

  $ = Backbone.$

  AddTodoWiget = Backbone.Epoxy.View.extend
    template: $('#AddTodoWidget').html()

    ui:
      $title: '[data-js-todo-title]'

    events:
      'click [data-js-todo-add]': 'onAddClick'
      'keypress [data-js-todo-title]': 'onTitleKeypress'

    initialize: ->
      @$el.html @template
      @render()
      @setUi()

    setUi: ->
      ui = {}
      _.each @ui, (element, key)=>
        ui[key] = @$(element)
      @ui = ui

    # название не совсем правдивое
    onAddClick: ->
      @addTodoItem @ui.$title.val()
      @ui.$title.val ''

    onTitleKeypress: (e)-> @onAddClick() if e.keyCode == 13

    # REVIEW: Вкусовщина : @collection.addNewItem {title} или
    # хотябы @collection.addNewItem {title: title}
    addTodoItem: (title)-> @collection.addNewItem title: title
