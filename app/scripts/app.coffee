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
      # экземпляры чего-то принято называть с маленькойБуквы
      # REVEIW: не вижу причены почему app должне знать о конкретных view
      # REVIEW: {collection}
      @pages.IndexPage = new IndexPage collection: collection
      @pages.TodoItemPage = new TodoItemPage collection: collection
      @pages.NotFoundPage = new NotFoundPage

    # REVIEW: думаю не attrs, opts или парамс
    showPage: (page, attrs) ->
      if @currPage
        @currPage.hide()
      # REVIEW: можно так, чуть короче
      # page.setAttributes? attrs if attrs
      if attrs && page.setAttributes
        page.setAttributes attrs
      @currPage = page
      # REVIEW: проверка не очень читается
      # REVIEW: было бы круто вынести в отдельный метод
      if ! (@$content.find page.$el).length
        @$content.append(@currPage.$el)
      @currPage.show()
