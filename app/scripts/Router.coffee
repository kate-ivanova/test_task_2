define (require, exports, module) ->
  Backbone = require 'backbone'
  TodoCollection = require 'collection/TodoCollection'
  IndexPage = require 'view/page/IndexPage/IndexPage'
  TodoItemPage = require 'view/page/TodoItemPage/TodoItemPage'
  NotFoundPage = require 'view/page/NotFoundPage/NotFoundPage'

  getUrlArgs = ()->
    res = {}
    urlArgs = location.href.split('?')[1]
    if urlArgs
      for arg in urlArgs.split('&')
        do (arg) ->
          name = arg.split('=')[0]
          val = arg.split('=')[1]
          res[name] = val
    res

  Router = Backbone.Router.extend
    routes:
      '': 'index'
      'items/:id': 'items'
      'search/:str': 'search'
      '*other': 'notFoundPage'

    index: (str)->
      urlArgs = getUrlArgs()
      # REVIEW: оочень длинные строки
      window.common.app.showPage(new IndexPage urlArgs)

    items: (id)->
      collection = new TodoCollection
      model = collection.get id
      window.common.app.showPage(new TodoItemPage model)

    notFoundPage: (other)->
      window.common.app.showPage(new NotFoundPage)

