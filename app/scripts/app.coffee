define (require, exports, module) ->
  Backbone = require 'backbone'
  IndexPage = require 'indexPage'
  TodoItemPage = require 'todoItemPage'
  TodoCollection = require 'todoCollection'
  TodoFilteredCollection = require 'todoFilteredCollection'

  App = () ->
    $content: $($('.content-block')[0])

    pages:
      IndexPage: null
      TodoItemPage: null

    initialize: ->
      collection = new TodoCollection()
      @pages.IndexPage = new IndexPage collection: collection
      @pages.TodoItemPage = new TodoItemPage collection: collection

    showPage: (page, attrs) ->
      page.setAttributes attrs
      page.render()
      @$content.html(page.$el)

