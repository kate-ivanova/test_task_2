define (require, exports, module) ->
  TodoCollection = require 'collection/TodoCollection'
  TodoFilteredCollection = require 'collection/TodoFilteredCollection'
  TodoListView = require 'view/list/TodoListView/TodoListView'
  Router = require 'Router'

  describe 'TodoListView', ->

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
      @todosFiltered = new TodoFilteredCollection null, {originalCollection: @todos}
      @view = new TodoListView {collection: @todosFiltered}
      @view.render()

    afterEach ->
      delete @todos
      delete @todosFiltered
      delete @view

    it 'should be defined', ->
      expect(@view).toBeDefined()

    it 'renders div.todo-list', ->
      expect(@view.$el.hasClass 'todo-list').toBeTruthy()

    it 'collection should change on item done click', ->
      eventSpy = sinon.spy()
      @view.collection.on 'change', eventSpy
      $item = $((@view.$el.find '.todo-list--item')[0])
      $checkbox = $item.find '.todo-list--item-done'
      $checkbox.trigger 'click'
      expect eventSpy.calledOnce

    it 'collection should change on item delete click', ->
      eventSpy = sinon.spy()
      @view.collection.on 'change', eventSpy
      $item = $((@view.$el.find '.todo-list--item')[0])
      $delete = $item.find '.todo-list--item-delete'
      $delete.trigger 'click'
      expect eventSpy.calledOnce

    it 'should route on item view click', ->
      eventSpy = sinon.spy(window.common.router, 'navigate')
      $item = $((@view.$el.find '.todo-list--item')[0])
      $view = $item.find '.todo-list--item-view'
      $view.trigger 'click'
      expect eventSpy.calledOnce

    it 'should change collection on done click', ->
      eventSpy = sinon.spy()
      @view.collection.on 'change', eventSpy
      $item = $((@view.$el.find '.todo-list--item')[0])
      $done = $item.find '.todo-list--item-done'
      $done.trigger 'click'
      expect eventSpy.calledOnce
