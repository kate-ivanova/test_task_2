define (require, exports, module) ->
  Backbone = require 'backbone'
  require 'backbone.epoxy'
  TodoItemView = require 'view/list/TodoListView/TodoListView'

  TodoItemPage = Backbone.Epoxy.View.extend

    # REVIEW: довольно странный метод
    setAttributes: (attrs)->
      @todoItem = @collection.get attrs
      @render() if @todoItem

    render: ->
      todoItemView = new TodoItemView model: @todoItem
      todoItemView.render()
      # REVIEW: это тот случай, когда создание переменной не очень помогает ;)
      # в одну строку тоже было бы норм
      $todoItemEl = todoItemView.$el
      @$el.html $todoItemEl
      this

    hide: -> @$el.toggleClass 'hide', true

    show: -> @$el.toggleClass 'hide', false
