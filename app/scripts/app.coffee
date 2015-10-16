define (require, exports, module) ->
  Backbone = require 'backbone'

  IndexPage = require 'view/page/IndexPage/IndexPage'
  TodoItemPage = require 'view/page/TodoItemPage/TodoItemPage'
  NotFoundPage = require 'view/page/NotFoundPage/NotFoundPage'
  TodoCollection = require 'collection/TodoCollection'

  App = () ->
    $content: $($('.content-block')[0])

    currPage: null

    pages:
      IndexPage: null
      TodoItemPage: null
      NotFoundPage: null

    initialize: ->
      collection = new TodoCollection
      @pages.IndexPage = new IndexPage collection: collection
      @pages.TodoItemPage = new TodoItemPage collection: collection
      @pages.NotFoundPage = new NotFoundPage

    showPage: (page, attrs) ->
      if @currPage
        @currPage.hide()
      if attrs && page.setAttributes
        page.setAttributes attrs
      @currPage = page
      if ! (@$content.find page.$el).length
        @$content.append(@currPage.$el)
      @currPage.show()
