define (require, exports, module) ->
  _Page = require 'view/page/_Page'

  describe '_Page', ->

    beforeEach ->
      @view = new _Page
      @view.render()

    afterEach ->
      delete @view

    it 'should be defined', ->
      expect(@view).toBeDefined()

    it 'should be displayed', ->
      @view.display true
      expect(@view.$el.hasClass 'hide').toBeFalsy()
      @view.display false
      expect(@view.$el.hasClass 'hide').toBeTruthy()

