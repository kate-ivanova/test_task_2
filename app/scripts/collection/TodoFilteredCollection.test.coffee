define (require, exports, module) ->
  TodoCollection = require 'collection/TodoCollection'
  TodoFilteredCollection = require 'collection/TodoFilteredCollection'

  describe 'TodoFilteredCollection', ->
    beforeAll ->
      # models list for todoCollection
      @modelsList = []
      @modelsList.push {'title': 'Title 1'}
      @modelsList.push {'title': 'Title 2'}
      @modelsList.push {'title': 'Title 3'}
      @modelsList.push {'title': 'Title 43', 'done': true}
      @modelsList.push {'title': 'Title 341', 'done': true}
      @modelsList.push {'title': 'Title 521', 'done': true}

    beforeEach ->
      @todos = new TodoCollection @modelsList
      @todosFiltered = new TodoFilteredCollection null, {originalCollection: @todos}

    afterEach ->
      delete @todos
      delete @todosFiltered

    afterAll ->
      delete @modelsList

    it 'should be defined', ->
      expect(@todosFiltered).toBeDefined()

    it 'should set originalCollection', ->
      expect(@todosFiltered.originalCollection).toEqual @todos
      expect(@todosFiltered.models).toEqual @todos.models

    it 'should have actual originalCollection', ->
      prevLength = @todosFiltered.originalCollection.length
      @todos.add {title: 'Title 5213', done: true}
      title = @todosFiltered.originalCollection.pop().get 'title'
      done = @todosFiltered.originalCollection.pop().get 'done'
      expect(title).toEqual 'Title 5213'
      expect(done).toEqual true

    it 'should correctly set filters', ->
      @todosFiltered.setFilters {title: 'title 1'}
      expect(@todosFiltered.filters).toEqual {title: 'title 1'}
      @todosFiltered.setFilters {done: true}
      expect(@todosFiltered.filters).toEqual {done: true}
      @todosFiltered.setFilters {title: 'title 1', done: true}
      expect(@todosFiltered.filters).toEqual {title: 'title 1', done: true}

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
      @todosFiltered.setFilters {title: 'title 3', done: false}
      expect(@todosFiltered.length).toEqual 1

    it 'should be refresh by changing originalCollection', ->
      @todosFiltered.setFilters {title: '1', done: true}
      @todos.add {title: 'Title 5213', done: true}
      expect(@todosFiltered.length).toEqual 3

