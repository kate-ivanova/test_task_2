define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoItemView = require 'view/list/TodoItemView/TodoItemView'

  TodoItemPage = Backbone.Epoxy.View.extend

    setAttributes: (attrs)->
      @todoItem = @collection.get attrs
      @render() if @todoItem

    render: ->
      todoItemView = new TodoItemView model: @todoItem
      todoItemView.render()
      $todoItemEl = todoItemView.$el
      @$el.html $todoItemEl
      this

    hide: -> @$el.toggleClass 'hide', true

    show: -> @$el.toggleClass 'hide', false
