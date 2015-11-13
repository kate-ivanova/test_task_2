define (require, exports, module) ->
  TodoCollection = require('collection/TodoCollection')
  TodoModel = require('model/TodoModel')
  describe 'TodoCollection testing', ->
    beforeEach ->
      @tasks = new TodoCollection
    it 'initial state', ->
      (expect @tasks.models.length).toEqual 0
    it 'add model', ->
      changeCallback = jasmine.createSpy '-event changeCallback-'
      @tasks.on 'change', changeCallback
      @tasks.addNewItem {}
      changeArgs = changeCallback.mostRecentCall.args
      (expect @tasks.models.length).toEqual 1
