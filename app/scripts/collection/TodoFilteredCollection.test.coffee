define (require, exports, module) ->
  TodoCollection = require 'collection/TodoCollection'
  TodoFilteredCollection = require 'collection/TodoFilteredCollection'

  describe 'TodoFilteredCollection', ->
    beforeAll ->
      # TodoModel stub
      @todoModelStub = sinon.stub()
      @model = new Backbone.Model
        title: ''
        done: false
      @todoModelStub.returns @model

      # models list for todoCollection stub
      @modelsList = []
      @modelsList.push {'title': 'Title 1'}
      @modelsList.push {'title': 'Title 2'}
      @modelsList.push {'title': 'Title 3'}
      @modelsList.push {'title': 'Title 43', 'done': true}
      @modelsList.push {'title': 'Title 341', 'done': true}
      @modelsList.push {'title': 'Title 521', 'done': true}


    beforeEach ->
      # TodoCollection stub
      @todosStub = new TodoCollection @modelsList
      @todosStub.model = @todoModelStub
      @todosStub.fetch = -> {}
      @todosStub.yield = -> {}

      # create new collection
      @todosFiltered = new TodoFilteredCollection
      @todosFiltered.model = @todoModelStub
      @todosFiltered.setOriginalCollection @todosStub

    it 'should be defined', ->
      expect(@todosFiltered).toBeDefined()

    it 'should set originalCollection', ->
      expect(@todosFiltered.originalCollection).toEqual(@todosStub)
      expect(@todosFiltered.models).toEqual(@todosStub.models)

    it 'should have actual originalCollection', ->
      prevLength = @todosFiltered.originalCollection.length
      model = new Backbone.Model {title: 'Title 5213', done: true}
      @todosStub.add model
      expect(@todosFiltered.originalCollection.pop().attributes)
        .toEqual {'title': 'Title 5213', 'done': true}

    it 'should correctly set filters', ->
      @todosFiltered.setFilters {title: 'title 1'}
      expect(@todosFiltered.filters).toEqual({title: 'title 1'})
      @todosFiltered.setFilters {done: true}
      expect(@todosFiltered.filters).toEqual({done: true})
      @todosFiltered.setFilters {title: 'title 1', done: true}
      expect(@todosFiltered.filters).toEqual({title: 'title 1', done: true})

    it 'should correctly apply filters', ->
      @todosFiltered.setFilters {title: '1'}
      expect(@todosFiltered.length).toEqual 3
      @todosFiltered.setFilters {title: 'title 1'}
      expect(@todosFiltered.length).toEqual 1
      @todosFiltered.setFilters {title: 'title 3'}
      expect(@todosFiltered.length).toEqual 2
      @todosFiltered.setFilters {done: false}
      expect(@todosFiltered.length).toEqual 3
      @todosFiltered.setFilters {done: true}
      expect(@todosFiltered.length).toEqual 3
      @todosFiltered.setFilters {title: '1', done: true}
      expect(@todosFiltered.length).toEqual 2
      @todosFiltered.setFilters {title: 'tiTle 3', done: false}
      expect(@todosFiltered.length).toEqual 1

    it 'should be refresh by changing originalCollection', ->
      @todosFiltered.setFilters {title: '1', done: true}
      model = new Backbone.Model {title: 'Title 5213', done: true}
      @todosStub.add model
      expect(@todosFiltered.length).toEqual 3

