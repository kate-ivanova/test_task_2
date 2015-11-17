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
      spy = sinon.spy()
      @todos.on 'change', spy
      prevLen = @todos.length
      @todos.add {'title': 'title 1'}
      expect(spy.calledOnce).toBe true
      expect(@todos.length).toBe(prevLen + 1)

    it 'should correctly remove item', ->
      @todos.add {'title': 'title 1'}
      spy = sinon.spy()
      @todos.on 'change', spy
      prevLen = @todos.length
      @todos.remove @todos.at(0)
      expect(spy.calledOnce).toBe true
      expect(@todos.length).toBe(prevLen - 1)

    it 'should yield to storage collection', ->
      @todos.add {'title': 'title_1'}
      expect(@storageTodos.models).toEqual @todos.models

    it 'should fetch from storage collection', ->
      @storageTodos.add {'title': 'title_1'}
      @todos.fetch()
      expect(@storageTodos.models).toEqual @todos.models

