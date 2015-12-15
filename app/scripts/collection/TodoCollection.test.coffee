define (require, exports, module) ->
  TodoCollection = require 'collection/TodoCollection'

  describe 'TodoCollection', ->

    beforeEach ->
      @todos = new TodoCollection

    afterEach ->
      delete @todos

    it 'should be defined', ->
      expect(@todos).toBeDefined()

