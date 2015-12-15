define (require, exports, module) ->
  TodoCollection = require 'collection/TodoCollection'
  TodoFilteredCollection = require 'collection/TodoFilteredCollection'
  FilterTodoWidget = require 'view/widget/FilterTodoWidget/FilterTodoWidget'
  Router = require 'Router'

  describe 'FilterTodoWidget', ->

    beforeAll ->
      window.common.router = new Router
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
      @todosFiltered = new TodoFilteredCollection [], {originalCollection: @todos}
      @view = new FilterTodoWidget {collection: @todosFiltered}
      @view.render()

    afterEach ->
      delete @todos
      delete @todosFiltered
      delete @view

    it 'should be defined', ->
      expect(@view).toBeDefined()

    it 'renders div.add-todo-widget', ->
      expect(@view.$el.hasClass 'filter-todo-widget').toBeTruthy()

    it 'should bind jquery elements to ui', ->
      expect(@view.ui).toBeDefined()
      _.each @view.ui, (value) ->
        expect(value.length).toBeGreaterThan 0

    it 'should correctly set filters', ->
      filters = {}
      filters.title = '3'
      filters.done = 'true'
      @view.setFilters filters
      expect(@view.collection.length).toBe 2

    it 'should filter on titleFilter input', ->
      title = 'Title 3'
      @view.ui.title.val title
      @view.ui.title.trigger 'input'
      expect(@view.collection.length).toBe 2

    it 'should filter on doneFilter change', ->
      done = 'false'
      @view.ui.done.val done
      @view.ui.done.trigger 'change'
      expect(@view.collection.length).toBe 3
