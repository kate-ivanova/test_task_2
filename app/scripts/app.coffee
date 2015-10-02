define (require, exports, module) ->
  Backbone = require 'backbone'
  IndexPage = require 'indexPage'
  TodoItemPage = require 'todoItemPage'

  App = () ->
    $content: $($('.content-block')[0])

    pages:
      IndexPage: (filters) ->
        new IndexPage filters
      TodoItemPage: (itemId) ->
        new TodoItemPage {todoItemId: itemId}

    showPage: (page, attrs) ->
      page.render()
      @$content.html(page.$el)

