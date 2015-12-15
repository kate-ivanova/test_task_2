define (require, exports, module) ->
  IndexPage = require 'view/page/IndexPage/IndexPage'
  Router = require 'Router'


  describe 'IndexPage', ->

    beforeAll ->
      window.common.router = new Router

    it 'should be defined', ->
      @view = new IndexPage
      expect(@view).toBeDefined()
      delete @view
      @view = new IndexPage {title: 'title'}
      expect(@view).toBeDefined()
      delete @view



