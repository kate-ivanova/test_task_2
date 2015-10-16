define (require, exports, module) ->
  Backbone = require 'backbone'
  common = require 'common'

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
      window.common.app.showPage window.common.app.pages.IndexPage, urlArgs

    items: (id)->
      window.common.app.showPage window.common.app.pages.TodoItemPage, id

    notFoundPage: (other)->
      window.common.app.showPage window.common.app.pages.NotFoundPage

