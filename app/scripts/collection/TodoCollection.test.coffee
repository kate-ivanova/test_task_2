define (require, exports, module) ->
  TodoCollection = require 'collection/TodoCollection'

  describe 'TodoCollection', ->
    beforeEach ->
      # TodoModel stub
      @todoModelStub = sinon.stub()
      @model = new Backbone.Model
        title: ''
        done: false
      @todoModelStub.returns @model

      # create new collection
      @todos = new TodoCollection
      @todos.model = @todoModelStub
      # stub interaction with localStorage
      @storageTodos = new Backbone.Collection
      @storageTodos.model = @todoModelStub
      sinon.stub @todos, 'fetch', =>
        @todos.set @storageTodos.models
      sinon.stub @todos, 'yield', =>
        @storageTodos.set @todos.models

    it 'should be defined', ->
      expect(@todos).toBeDefined()

    it 'should correctly add item', ->
      spy = sinon.spy(@todos, 'add')
      prevLen = @todos.length
      @todos.addNewItem {}
      expect(spy.calledOnce).toBe true
      expect(@todos.length).toBe prevLen + 1

    it 'should yield to storage collection', ->
      @todos.addNewItem {'title': 'title_1'}
      expect(@storageTodos.models).toEqual @todos.models

    it 'should fetch from storage collection', ->
      @storageTodos.add {'title': 'title_1'}
      @todos.fetch()
      expect(@storageTodos.models).toEqual @todos.models

